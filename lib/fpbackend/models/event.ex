defmodule FpbackendWeb.Event do
  use Fpbackend.Web, :model


  schema "events" do
    field :name, :string
    field :description, :string
    field :num_participants, :integer
    field :minimum_age, :integer
    field :price, :integer
    field :date_start, Timex.Ecto.Date
    field :date_end, Timex.Ecto.Date
    field :reg_date_open, Timex.Ecto.DateTime
    field :reg_date_close, Timex.Ecto.DateTime
    field :rules, :string

    has_many :activities, Fpbackend.Activity
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :num_participants, :minimum_age, :price, :date_start, :date_end, :reg_date_open, :reg_date_close, :rules])
    |> validate_required([:name, :description, :num_participants, :minimum_age, :price, :date_start, :date_end, :reg_date_open, :reg_date_close, :rules])
    |> unique_constraint(:name)
  end

  #TODO Refactor validations
end
