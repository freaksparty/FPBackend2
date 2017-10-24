defmodule Fpbackend.Services.EventService do
  use Fpbackend.Web, :fpbackend_service

  alias FpbackendWeb.Event

  def repo(), do: Event
  def model_struct(), do: %Event{}
  def create_changeset(struct, params), do: Event.changeset(struct, params)
  def update_changeset(struct, params), do: Event.changeset(struct, params)

end
