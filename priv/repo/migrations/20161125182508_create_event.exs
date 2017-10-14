defmodule Fpbackend.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string, null: false, size: 150
      add :description, :text
      add :num_participants, :integer, default: 1
      add :minimum_age, :integer, default: 0
      add :price, :integer, default: 0
      add :date_start, :date, null: false
      add :date_end, :date, null: false
      add :reg_date_open, :utc_datetime, null: false
      add :reg_date_close, :utc_datetime, null: false
      add :rules, :string
    end

    create unique_index(:events, [:name])

  end
end
