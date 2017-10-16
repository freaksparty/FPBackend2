defmodule FpbackendWeb.Activity do
  use Fpbackend.Web, :model

  @name_min 3
  @name_max 150

  @description_min 30
  @description_max 65535

  @num_participants_min 0

  schema "activities" do
    field :name, :string
    field :description, :string
    field :image_url, :string
    field :num_participants, :integer
    field :type, :string
    field :official, :boolean, default: false
    field :date_start, Timex.Ecto.DateTime
    field :date_end, Timex.Ecto.DateTime
    field :reg_date_open, Timex.Ecto.DateTime
    field :reg_date_close, Timex.Ecto.DateTime

    belongs_to :event, FpbackendWeb.Event
  end

  #TODO: Date checks

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :image_url, :num_participants, :type, :official, :date_start, :date_end, :reg_date_open, :reg_date_close, :event_id])
    |> validate_required([:name, :description, :num_participants, :type, :date_end, :reg_date_close, :event_id])
    |> validate_name
    |> validate_description
    |> validate_type
    |> validate_image_url
    |> validate_num_participants
  end

  defp validate_name(changeset) do
    changeset
    |> range(:name, @name_min, @name_max)
  end

  defp validate_description(changeset) do
    changeset
    |> range(:description, @description_min, @description_max)
  end

  defp validate_type(changeset) do
    changeset
    |> activity_types(:type)
  end
    
  defp validate_image_url(changeset) do
    changeset
    |> url(:image_url)
  end

  defp validate_num_participants(changeset) do
    changeset
    |> min_length(:num_participants, @num_participants_min)
  end

end
