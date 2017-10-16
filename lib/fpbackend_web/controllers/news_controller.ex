defmodule FpbackendWeb.NewsController do
  use Fpbackend.Web, :fpbackend_controller

  def service(), do: Fpbackend.Services.NewsService
  def many_key(), do: :news
  def one_key(), do: :news

  def index(conn, %{"event_id" => event_id}), do: conn |> base_index(service().from_event_query(event_id))
  def show(conn, %{"event_id" => event_id, "id" => id}), do: conn |> base_show(id, service().from_event_query(event_id))
  def create(conn, %{"event_id" => event_id, "news" => news_params}), do: conn |> base_create(Map.put(news_params, :event_id, event_id))
  def update(conn, %{"id" => id, "news" => news_params}), do: conn |> base_update(id, news_params)
  def delete(conn, %{"id" => id}), do: conn |> base_delete(id)
end
