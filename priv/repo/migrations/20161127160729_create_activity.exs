defmodule Fpbackend.Repo.Migrations.CreateActivity do
  use Ecto.Migration

  def change do
    create table(:activities) do
      add :name, :string, null: false, size: 150
      add :description, :text
      add :image_url, :string
      add :num_participants, :integer, null: false, default: 1
      add :type, :varchar, null: false
      add :official, :boolean, default: false, null: false
      add :date_start, :utc_datetime
      add :date_end, :utc_datetime, null: false
      add :reg_date_open, :utc_datetime
      add :reg_date_close, :utc_datetime, null: false
      add :event_id, references(:events, on_delete: :delete_all, on_update: :update_all), null: false
    end

    create index(:activities, [:event_id])
  end
end
