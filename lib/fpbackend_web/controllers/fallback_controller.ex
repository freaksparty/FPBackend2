defmodule FpbackendWeb.FallbackController do
  use Fpbackend.Web, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> assign(:changeset, changeset)
    |> error(FpbackendWeb.ChangesetView, :unprocessable_entity, "error.json")
  end

  def call(conn, {:error, :not_found}), do: conn |> error(:not_found)

  def call(conn, _reason) do
    conn |> error(:internal_server_error)
  end
end
