defmodule Fpbackend.Repo.Migrations.AddNotNullDescriptionActivity do
  use Ecto.Migration

  def change do
    alter table(:activities) do
      modify :description, :text, null: false
    end
  end
end
