defmodule FpbackendWeb.Sponsor do
  use Fpbackend.Web, :model

  @name_min 3
  @name_max 75

  schema "sponsors" do
    field :name, :string
    field :url, :string
    field :image_url, :string

    belongs_to :event, FpbackendWeb.Event
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :url, :image_url])
    |> validate_required([:name, :image_url])
    |> validate_name
    |> validate_url
    |> validate_image_url
  end

  defp validate_name(changeset) do
    changeset
    |> range(:name, @name_min, @name_max)
  end

  defp validate_url(changeset) do
    changeset
    |> url(:url)
  end

  defp validate_image_url(changeset) do
    changeset
    |> url(:image_url)
  end

end
