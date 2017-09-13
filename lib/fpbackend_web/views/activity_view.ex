defmodule FpbackendWeb.ActivityView do
  use Fpbackend.Web, :view

  def render("index.json", %{activities: activities}) do
    render_many(activities, FpbackendWeb.ActivityView, "activity.json")
  end

  def render("show.json", %{activity: activity}) do
    render_one(activity, FpbackendWeb.ActivityView, "activity.json")
  end

  def render("activity.json", %{activity: activity}) do
    %{id: activity.id,
      event_id: activity.event_id,
      name: activity.name,
      description: activity.description,
      image_url: activity.image_url,
      num_participants: activity.num_participants,
      type: activity.type,
      official: activity.official,
      date_start: activity.date_start,
      date_end: activity.date_end,
      reg_date_open: activity.reg_date_open,
      reg_date_close: activity.reg_date_close}
  end

  def render("activity_basic.json", %{activity: activity}) do
    %{id: activity.id,
      name: activity.name}
  end
end
