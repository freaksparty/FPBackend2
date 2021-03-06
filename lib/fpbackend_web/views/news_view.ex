defmodule FpbackendWeb.NewsView do
  use Fpbackend.Web, :view

  def render("many.json", %{news: news}) do
    render_many(news, FpbackendWeb.NewsView, "news.json")
  end

  def render("many.json", %{basic_news: news}) do
    render_many(news, FpbackendWeb.NewsView, "basic.json")
  end

  def render("one.json", %{news: news}) do
    render_one(news, FpbackendWeb.NewsView, "news.json")
  end

  def render("news.json", %{news: news}) do
    %{id: news.id,
      event_id: news.event_id,
      creator: news.creator,
      title: news.title,
      image_url: news.image_url,
      content: news.content,
      summary: news.summary,
      created_at: news.created_at,
      published_at: news.published_at,
      priority: news.priority,
      priority_hours: news.priority_hours}
  end

  def render("basic.json", %{news: news}) do
    %{id: news.id,
      creator: render_one(news.user, FpbackendWeb.UserView, "name.json", as: :user),
      title: news.title,
      summary: news.summary,
      image_url: news.image_url,
      published_at: news.published_at,
      priority: news.priority}
  end
end
