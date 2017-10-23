defmodule FpbackendWeb.News do
  use Fpbackend.Web, :model

  @title_min 3
  @title_max 150

  @content_min 30
  @content_max 65536

  @priority_hours_min 0
  @summary_length 200
  @summary_ellipsis "..."

  # TODO: Validate dates ranges

  schema "news" do
    field :title, :string
    field :image_url, :string
    field :content, :string
    field :summary, :string
    field :reg_date_created, Timex.Ecto.DateTime
    field :reg_date_publish, Timex.Ecto.DateTime
    field :priority, :boolean, default: false
    field :priority_hours, :integer, default: 0

    belongs_to :event, FpbackendWeb.Event
    belongs_to :user, FpbackendWeb.User, foreign_key: :creator
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :image_url, :content, :reg_date_created, :reg_date_publish, :priority, :priority_hours, :event_id, :creator])
    |> validate_required([:title, :content, :event_id, :creator])
    |> validate_title
    |> validate_content
    |> validate_image_url
    |> validate_priority_hours
    |> generate_summary
  end

  defp validate_title(changeset) do
    changeset
    |> range(:title, @title_min, @title_max)
  end

  defp validate_content(changeset) do
    changeset
    |> range(:content, @content_min, @content_max)
  end

  defp validate_image_url(changeset) do
    changeset
    |> url(:image_url)
  end

  defp validate_priority_hours(changeset) do
    changeset
    |> min_count(:priority_hours, @priority_hours_min)
  end

  defp generate_summary(%Ecto.Changeset{valid?: true, changes: %{content: content}} = news), do: news |> change(summary: create_summary(content))
  defp generate_summary(news), do: news

  defp create_summary(content) when length(content) < @summary_length, do: content
  defp create_summary(content) do
    first = 0
    last = @summary_length - 1 - String.length(@summary_ellipsis)

    String.slice(content, first..last) <> @summary_ellipsis
  end
end
