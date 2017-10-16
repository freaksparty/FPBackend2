defmodule FpbackendWeb.EventController do
  use Fpbackend.Web, :fpbackend_controller

  def service(), do: Fpbackend.Services.EventService
  def many_key(), do: :events
  def one_key(), do: :event

  def index(conn, _params), do: conn |> base_index()
  def show(conn, %{"id" => id}), do: conn |> base_show(id)
  def create(conn, %{"event" => event_params}), do: conn |> base_create(event_params)
  def update(conn, %{"id" => id, "event" => event_params}), do: conn |> base_update(id, event_params)
  def delete(conn, %{"id" => id}), do: conn |> base_delete(id)

  def all_nested(conn, %{"event_id" => id}) do 
    with query <- service().with_all_nested_query(), 
         {:ok, data} <- service().one(id, query) do
      conn |> assign(one_key(), data) |> ok(:ok, "all_nested.json")
    end
  end

end
