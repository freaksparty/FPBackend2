defmodule FpbackendWeb.EventView do
  use Fpbackend.Web, :view

  def render("many.json", %{events: events}) do
    render_many(events, FpbackendWeb.EventView, "event.json")
  end

  def render("one.json", %{event: event}) do
    render_one(event, FpbackendWeb.EventView, "event.json")
  end

  def render("all_nested.json", %{event: event}) do
    render("event.json", %{event: event})
    |> Map.put_new(:activities, render_many(event.activities, FpbackendWeb.ActivityView, "basic.json", as: :activity))
    |> Map.put_new(:news, render_many(event.news, FpbackendWeb.NewsView, "basic.json", as: :news))
  end

  def render("event.json", %{event: event}) do
    %{id: event.id,
      name: event.name,
      description: event.description,
      num_participants: event.num_participants,
      minimum_age: event.minimum_age,
      price: event.price,
      date_start: event.date_start,
      date_end: event.date_end,
      reg_date_open: event.reg_date_open,
      reg_date_close: event.reg_date_close,
      rules: event.rules}
  end
end
