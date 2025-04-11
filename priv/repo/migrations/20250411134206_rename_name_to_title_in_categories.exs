defmodule HolzLog.Repo.Migrations.RenameNameToTitleInCategories do
  use Ecto.Migration

  def change do
    rename table(:categories), :name, to: :title
  end
end
