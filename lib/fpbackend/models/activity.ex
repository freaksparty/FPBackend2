defmodule FpbackendWeb.Activity do
  use Fpbackend.Web, :model

  schema "activities" do
    field :name, :string
    field :description, :string
    field :image_url, :string
    field :num_participants, :integer
    field :type, :integer
    field :official, :boolean, default: false
    field :date_start, Timex.Ecto.DateTime
    field :date_end, Timex.Ecto.DateTime
    field :reg_date_open, Timex.Ecto.DateTime
    field :reg_date_close, Timex.Ecto.DateTime
    belongs_to :event, Fpbackend.Event
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :image_url, :num_participants, :type, :official, :date_start, :date_end, :reg_date_open, :reg_date_close, :event_id])
    |> validate_required([:name, :description, :image_url, :num_participants, :type, :official, :date_start, :date_end, :reg_date_open, :reg_date_close, :event_id])
    |> foreign_key_constraint(:event_id)
  end

  #TODO Refactor validations
end
