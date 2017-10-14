defmodule FpbackendWeb.EventView do
  use Fpbackend.Web, :view

  def render("many.json", %{events: events}) do
    render_many(events, FpbackendWeb.EventView, "event.json")
  end

  def render("one.json", %{event: event}) do
    render_one(event, FpbackendWeb.EventView, "event.json")
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
