defmodule FpbackendWeb.User do
  use Fpbackend.Web, :model

  import Comeonin

  @login_min 3
  @login_max 25

  @password_min 8
  @password_max 255

  @name_min 3
  @name_max 100

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
    field :borndate, Timex.Ecto.Date

    has_many :news, FpbackendWeb.News, foreign_key: :creator
  end

  def registration_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:login, :password, :name, :dni, :email, :phone, :shirt_size, :borndate])
    |> required([:login, :password, :name, :dni, :email, :phone, :shirt_size, :borndate])
    |> validate_login
    |> validate_password
    |> validate_name
    |> validate_dni
    |> validate_email
    |> validate_phone
    |> validate_shirt_size
    |> hash_password
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:login, :name, :checked, :dni, :email, :phone, :shirt_size, :blacklist, :borndate])
    |> validate_required([:login, :name, :checked, :dni, :email, :phone, :shirt_size, :blacklist, :borndate])
    |> validate_login
    |> validate_password
    |> validate_name
    |> validate_dni
    |> validate_email
    |> validate_phone
    |> validate_shirt_size
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = user), do: user |> change(password_hash: Comeonin.Bcrypt.hashpwsalt(password))
  defp hash_password(user), do: user

  # VALIDATIONS

  defp validate_login(changeset) do
    changeset
    |> range(:login, @login_min, @login_max)
    |> unique(:login)
  end

  defp validate_password(changeset) do
    changeset
    |> range(:password, @password_min, @password_max)
  end

  defp validate_name(changeset) do
    changeset
    |> range(:name, @name_min, @name_max)
  end

  defp validate_dni(changeset) do
    #TODO: Do dni validation
    changeset
    |> unique(:dni)
  end

  defp validate_email(changeset) do
    changeset
    |> email(:email)
    |> unique(:email)
  end

  defp validate_phone(changeset) do
    changeset
    |> phone(:phone)
  end

  defp validate_shirt_size(changeset) do
    changeset
    |> shirt(:shirt_size)
  end
end
