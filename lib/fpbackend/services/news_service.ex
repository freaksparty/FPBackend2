defmodule Fpbackend.Services.NewsService do
  use Fpbackend.Web, :fpbackend_service

  alias FpbackendWeb.News

  def repo(), do: News
  def model_struct(), do: %News{}
  def create_changeset(struct, params), do: News.changeset(struct, params)
  def update_changeset(struct, params), do: News.changeset(struct, params)

  def from_event_query(event_id), do: from news in News, where: news.event_id == ^event_id

end
