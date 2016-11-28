defmodule Fpbackend.Repo.Migrations.CreateActivity do
  use Ecto.Migration

  def change do
    create table(:activities) do
      add :name, :string, null: false, size: 150
      add :description, :mediumtext
      add :image_url, :string
      add :num_participants, :integer, null: false, default: 1
      add :type, :integer, null: false
      add :official, :boolean, default: false, null: false
      add :date_start, :datetime
      add :date_end, :datetime, null: false
      add :reg_date_open, :datetime
      add :reg_date_close, :datetime, null: false
      add :event_id, references(:events, on_delete: :delete_all, on_update: :update_all), null: false
    end

    create index(:activities, [:event_id])
  end
end
