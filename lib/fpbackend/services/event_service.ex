defmodule Fpbackend.Services.EventService do
  use Fpbackend.Web, :fpbackend_service

  alias FpbackendWeb.Event

  def repo(), do: Event
  def model_struct(), do: %Event{}
  def create_changeset(struct, params), do: Event.changeset(struct, params)
  def update_changeset(struct, params), do: Event.changeset(struct, params)

  def with_all_nested_query() do
    activity_fields = [:id, :name, :type, :official]
    user_fields = [:id, :name]
    news_fields = [:id, :title, :image_url, :reg_date_publish, :priority, :priority_hours,
                   user: user_fields]
    event_fields = [:id, :name, :description, :num_participants, :minimum_age, :price, :date_start, :date_end, :reg_date_open, :reg_date_close, :rules,
                    activities: activity_fields, 
                    news: news_fields]

    now = Timex.now

    from event in Event, 
      left_join: activities in assoc(event, :activities),
      left_join: news in assoc(event, :news),
      left_join: user in assoc(news, :user),
      on: news.reg_date_publish <= ^now,
      preload: [activities: activities, news: {news, user: user}],
      select: map(event, ^event_fields) 
  end

end
