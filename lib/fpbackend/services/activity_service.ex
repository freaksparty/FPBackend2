defmodule Fpbackend.Services.ActivityService do
  use Fpbackend.Web, :fpbackend_service

  alias FpbackendWeb.Activity
  alias FpbackendWeb.Event

  def repo(), do: Activity
  def model_struct(), do: %Activity{}
  def create_changeset(struct, params), do: Activity.changeset(struct, params)
  def update_changeset(struct, params), do: Activity.changeset(struct, params)

  def from_event_query(event_id), do: from activity in Activity, where: activity.event_id == ^event_id
end
