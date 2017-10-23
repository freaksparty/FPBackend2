defmodule Fpbackend.Repo.Migrations.RenameDescriptionSummaryNews do
  use Ecto.Migration

  def change do
    rename table("news"), :description, to: :summary
  end
end
