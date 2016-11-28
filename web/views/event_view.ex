defmodule Fpbackend.EventView do
  use Fpbackend.Web, :view

  def render("index.json", %{events: events}) do
    render_many(events, Fpbackend.EventView, "event.json")
  end

  def render("show.json", %{event: event}) do
    render_one(event, Fpbackend.EventView, "event.json")
  end

  def render("show_all.json", %{event: event}) do
    render_one(event, Fpbackend.EventView, "event_all.json")
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

  def render("event_all.json", %{event: event}) do
     render("event.json", %{event: event})
     |> Map.put_new(:activities, render_many(event.activities, Fpbackend.ActivityView, "activity_basic.json", as: :activity))
  end
end
