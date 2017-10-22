defmodule Fpbackend.Repo.Migrations.AddDescriptionNews do
  use Ecto.Migration

  def change do
    alter table(:news) do
      add :description, :string, null: false, size: 200, default: ""
    end
  end
end
