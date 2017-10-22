defmodule Fpbackend.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use Fpbackend.Web, :controller
      use Fpbackend.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def service do
    quote do
      import Ecto
      import Ecto.Query

      alias Fpbackend.Repo
    end
  end

  def fpbackend_service do
    quote do
      use Fpbackend.Web, :service

      alias Fpbackend.Repo

      @behaviour FpbackendWeb.Service

      def create(params), do: model_struct() |> create_changeset(params) |> Repo.insert

      def one(id, :repo), do: do_one(id, repo())
      def one(id, query), do: do_one(id, query)

      defp do_one(id, query) do
        case Repo.get(query, id) do
          nil -> {:error, :not_found}
          data -> {:ok, data}
        end
      end

      def all(:repo), do: Repo.all(repo())
      def all(query), do: Repo.all(query)

      def update(id, params) do
        with {:ok, data} <- one(id, repo()),
            changeset <- update_changeset(data, params) do
          Repo.update(changeset)
        end
      end

      def delete(id) do
        with {:ok, data} <- one(id, repo()) do
          case Repo.delete data do
            {:ok, _} ->  :ok
          end
        end
      end

    end
  end

  def model do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      @shirt_sizes ~w(XS S M L XL XXL)
      @activity_types ~w(production tournament conference workshop)

      def unique(changeset, field), do: unique_constraint(changeset, field, message: "unique")
      def foreign(changeset, field), do: foreign_key_constraint(changeset, field, message: "foreign")
      def required(changeset, fields), do: validate_required(changeset, fields, message: "required")
      def format(changeset, field, reg_exp), do: validate_format(changeset, field, reg_exp, message: "format")
      def acceptance(changeset, field), do: validate_acceptance(changeset, field, message: "consent")
      def min_length(changeset, field, value), do: validate_length(changeset, field, min: value, message: "min:#{value}")
      def max_length(changeset, field, value), do: validate_length(changeset, field, max: value, message: "max:#{value}")
      def min_count(changeset, field, value), do: validate_number(changeset, field, greater_than_or_equal_to: value, message: "min:#{value}")
      def max_count(changeset, field, value), do: validate_number(changeset, field, less_than_or_equal_to: value, message: "max:#{value}")
      def range(changeset, field, min_value, max_value), do: changeset |> min_length(field, min_value) |> max_length(field, max_value)
      def range_count(changeset, field, min_value, max_value), do: changeset |> min_count(field, min_value) |> max_count(field, max_value)
      def inclusion(changeset, field, list), do: validate_inclusion(changeset, field, list, message: "inclusion")

      def email(changeset, field), do: format(changeset, field, ~r/(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)/)
      def phone(changeset, field), do: format(changeset, field, ~r/(^[0-9]{7,14}$)/)
      def url(changeset, field), do: format(changeset, field, ~r/^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/i)
      def shirt(changeset, field), do: inclusion(changeset, field, @shirt_sizes)
      def activity_types(changeset, field), do: inclusion(changeset, field, @activity_types)
    end
  end

  def controller do
    quote do
      use Phoenix.Controller, namespace: FpbackendWeb

      import Ecto
      import Ecto.Query

      import FpbackendWeb.Router.Helpers
      import FpbackendWeb.Gettext

      action_fallback FpbackendWeb.FallbackController

      def error(conn, type), do: conn |> send_empty_response(type)
      def error(conn, type, json), do: conn |> send_response(type, json)
      def error(conn, view, type, json), do: conn |> send_response(view, type, json)
      def changeset_error(conn, changeset), do: conn |> assign(:changeset, changeset) |> error(FpbackendWeb.ChangesetView, :unprocessable_entity, "error.json")

      def ok(conn, type), do: conn |> send_empty_response(type)
      def ok(conn, type, json), do: conn |> send_response(type, json)
      def ok(conn, view, type, json), do: conn |> send_response(view, type, json)

      defp send_empty_response(conn, type), do: conn |> send_resp(type, "")
      defp send_response(conn, type, json), do: conn |> put_status(type) |> render(json)
      defp send_response(conn, view, type, json), do: conn |> put_status(type) |> render(view, json)
    end
  end

  def fpbackend_controller do
    quote do
      use Fpbackend.Web, :controller

      @behaviour FpbackendWeb.Controller

      def base_index(conn, query \\ :repo), do: with data <- service().all(query), do: conn |> assign(many_key(), data) |> ok(:ok, "many.json")
      def base_show(conn, id, query \\ :repo), do: with {:ok, data} <- service().one(id, query), do: conn |> assign(one_key(), data) |> ok(:ok, "one.json")
      def base_create(conn, params), do: with {:ok, data} <- service().create(params), do: conn |> ok(:created)
      def base_update(conn, id, params), do: with {:ok, data} <- service().update(id, params), do: conn |> assign(one_key(), data) |> ok(:ok, "one.json")
      def base_delete(conn, id), do: with :ok <- service().delete(id), do: conn |> ok(:no_content)
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/fpbackend_web/templates",
                        namespace: FpbackendWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      import FpbackendWeb.Router.Helpers
      import FpbackendWeb.ErrorHelpers
      import FpbackendWeb.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      alias Fpbackend.Repo
      import Ecto
      import Ecto.Query
      import FpbackendWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
