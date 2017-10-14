defmodule FpbackendWeb.ActivityController do
  use Fpbackend.Web, :fpbackend_controller

  def service(), do: Fpbackend.Services.ActivityService
  def many_key(), do: :activities
  def one_key(), do: :activity

  def index(conn, %{"event_id" => event_id}), do: conn |> base_index(service().from_event_query(event_id))
  def show(conn, %{"event_id" => event_id, "id" => id}), do: conn |> base_show(id, service().from_event_query(event_id))
  def create(conn, %{"event_id" => event_id, "activity" => activity_params}), do: conn |> base_create(Map.put(activity_params, :event_id, event_id))
  def update(conn, %{"id" => id, "activity" => activity_params}), do: conn |> base_update(id, activity_params)
  def delete(conn, %{"id" => id}), do: conn |> base_delete(id)
end
