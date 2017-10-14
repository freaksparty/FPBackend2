defmodule FpbackendWeb.Event do
  use Fpbackend.Web, :model

  @name_min 3
  @name_max 100

  @description_min 30
  @description_max 65535

  @num_participants_min 0

  @minimum_age_min 0

  @price_min 0

  @rules_min 30
  @rules_max 65535

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

    has_many :activities, FpbackendWeb.Activity
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :num_participants, :minimum_age, :price, :date_start, :date_end, :reg_date_open, :reg_date_close, :rules])
    |> validate_required([:name, :description, :num_participants, :minimum_age, :price, :date_start, :date_end, :reg_date_open, :reg_date_close, :rules])
    |> validate_name
    |> validate_description
    |> validate_num_participants
    |> validate_minimum_age
    |> validate_price
    |> validate_rules
  end

  defp validate_name(changeset) do
    changeset
    |> min(:name, @name_min)
    |> max(:name, @name_max)
    |> unique(:name)
  end

  defp validate_description(changeset) do
    changeset
    |> min(:description, @description_min)
    |> max(:description, @description_max)
  end

  defp validate_num_participants(changeset) do
    changeset
    |> min(:num_participants, @num_participants_min)
  end

  defp validate_minimum_age(changeset) do
    changeset
    |> min(:minimum_age, @minimum_age_min)
  end

  defp validate_price(changeset) do
    changeset
    |> min(:price, @price_min)
  end

  defp validate_rules(changeset) do
    changeset
    |> min(:rules, @rules_min)
    |> max(:rules, @rules_max)
  end

  #TODO validate dates ranges
end
