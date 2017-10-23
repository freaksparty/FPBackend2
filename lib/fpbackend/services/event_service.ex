defmodule Fpbackend.Services.EventService do
  use Fpbackend.Web, :fpbackend_service

  alias FpbackendWeb.Event

  def repo(), do: Event
  def model_struct(), do: %Event{}
  def create_changeset(struct, params), do: Event.changeset(struct, params)
  def update_changeset(struct, params), do: Event.changeset(struct, params)

  def with_all_nested_query() do
    activity_fields = [:id, :name, :type, :official]
    event_fields = [:id, :name, :description, :num_participants, :minimum_age, :price, :date_start, :date_end, :reg_date_open, :reg_date_close, :rules,
                    activities: activity_fields]

    from event in Event, 
      left_join: activities in assoc(event, :activities),
      left_join: news in assoc(event, :news),
      left_join: user in assoc(news, :user),
      preload: [activities: activities],
      select: map(event, ^event_fields) 
  end

end
