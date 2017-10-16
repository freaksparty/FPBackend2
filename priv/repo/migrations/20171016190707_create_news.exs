defmodule Fpbackend.Repo.Migrations.CreateNews do
  use Ecto.Migration

  def change do
    create table(:news) do
      add :title, :string, null: false, size: 150
      add :image_url, :text
      add :content, :text, null: false
      add :reg_date_created, :utc_datetime, null: false
      add :reg_date_publish, :utc_datetime, null: false
      add :priority, :boolean, null: false, default: false
      add :priority_hours, :integer, null: false, default: 0

      add :event_id, references(:events, on_delete: :delete_all, on_update: :update_all), null: false
      add :creator, references(:users, on_delete: :delete_all, on_update: :update_all), null: false
    end

    create index(:news, [:event_id])
    create index(:news, [:creator])
  end
end
