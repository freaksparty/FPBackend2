defmodule Fpbackend.Repo.Migrations.CreateSponsor do
  use Ecto.Migration

  def change do
    create table(:sponsors) do
      add :name, :string, null: false, size: 75
      add :url, :string
      add :image_url, :string, null: false

      add :event_id, references(:events, on_delete: :delete_all, on_update: :update_all), null: false
    end

    create index(:sponsors, [:event_id])
  end
end
