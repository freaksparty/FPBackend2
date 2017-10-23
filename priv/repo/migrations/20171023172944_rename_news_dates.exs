defmodule Fpbackend.Repo.Migrations.RenameNewsDates do
  use Ecto.Migration

  def change do
    rename table("news"), :reg_date_publish, to: :published_at
    rename table("news"), :reg_date_created, to: :created_at
  end
end
