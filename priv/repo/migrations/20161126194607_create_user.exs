defmodule Fpbackend.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :login, :string, size: 200, null: false
      add :password_hash, :string, size: 128, null: false
      add :checked, :boolean, default: false, null: false
      add :name, :string, size: 250, null: false
      add :dni, :string, size: 11, null: false
      add :email, :string, size: 200, null: false
      add :phone, :string, size: 15
      add :shirt_size, :string, size: 3
      add :blacklist, :boolean, default: false, null: false
      add :borndate, :date
    end

    create unique_index(:users, [:login])
    create unique_index(:users, [:dni])
    create unique_index(:users, [:email])

  end
end
