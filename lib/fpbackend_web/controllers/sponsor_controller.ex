defmodule FpbackendWeb.SponsorController do
  use Fpbackend.Web, :fpbackend_controller

  def service(), do: Fpbackend.Services.SponsorService
  def many_key(), do: :sponsors
  def one_key(), do: :sponsor

  def index(conn, %{"event_id" => event_id}), do: conn |> base_index(service().from_event_query(event_id))
  def show(conn, %{"event_id" => event_id, "id" => id}), do: conn |> base_show(id, service().from_event_query(event_id))
  def create(conn, %{"event_id" => event_id, "sponsor" => sponsor_params}), do: conn |> base_create(Map.put(sponsor_params, :event_id, event_id))
  def update(conn, %{"id" => id, "sponsor" => sponsor_params}), do: conn |> base_update(id, sponsor_params)
  def delete(conn, %{"id" => id}), do: conn |> base_delete(id)
end
