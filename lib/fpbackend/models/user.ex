defmodule FpbackendWeb.User do
  use Fpbackend.Web, :model

  schema "users" do
    field :login, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :checked, :boolean, default: false
    field :name, :string
    field :dni, :string
    field :email, :string
    field :phone, :string
    field :shirt_size, :string
    field :blacklist, :boolean, default: false
    field :borndate, Ecto.Date
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def registration_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:login, :password, :name, :dni, :email, :phone, :shirt_size, :borndate])
    |> validate_required([:login, :password, :name, :dni, :email, :phone, :shirt_size, :borndate])
    |> hash_password
    |> common_validations
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:login, :name, :checked, :dni, :email, :phone, :shirt_size, :blacklist, :borndate])
    |> validate_required([:login, :name, :checked, :dni, :email, :phone, :shirt_size, :blacklist, :borndate])
    |> common_validations
  end

  defp common_validations(changeset) do
    changeset
    |> unique_constraint(:login)
    |> unique_constraint(:dni)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
  end

  defp hash_password(changeset) do
    case changeset.changes do
      %{password: password} -> put_change(changeset, :password_hash, do_hash(password))
      _ -> changeset
    end
  end

  #TODO Refactor validations

  defp do_hash(value), do: :crypto.hash(:sha512, value) |> Base.encode16 |> String.downcase
end
