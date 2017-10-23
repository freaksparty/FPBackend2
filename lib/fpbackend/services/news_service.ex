defmodule Fpbackend.Services.NewsService do
  use Fpbackend.Web, :fpbackend_service

  alias FpbackendWeb.News

  @creator_basic_projection [:id, :name]
  @basic_projection [:id, :creator, :title, :summary, :image_url, :published_at, :priority, user: @creator_basic_projection]

  def repo(), do: News
  def model_struct(), do: %News{}
  def create_changeset(struct, params), do: News.changeset(struct, params)
  def update_changeset(struct, params), do: News.changeset(struct, params)

  def from_event_query(event_id), do: from news in News, where: news.event_id == ^event_id

  def from_event_basic_sorted_query(event_id) do
    from_event = from_event_query(event_id)

    from news in from_event,
    left_join: user in assoc(news, :user),
    preload: [user: user],
    order_by: [desc: news.priority, desc: news.published_at],
    select: map(news, ^@basic_projection)
  end

end
