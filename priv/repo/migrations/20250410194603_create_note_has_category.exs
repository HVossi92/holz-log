defmodule HolzLog.Repo.Migrations.CreateNoteHasCategory do
  use Ecto.Migration

  def change do
    create table(:note_has_category, primary_key: false) do
      add :note_id, references(:notes, on_delete: :delete_all)
      add :category_id, references(:categories, on_delete: :delete_all)
    end

    create unique_index(:note_has_category, [:note_id, :category_id])
  end
end
