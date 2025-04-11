defmodule HolzLog.Log.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :title, :string
    many_to_many :notes, HolzLog.Log.Note, join_through: "note_has_category"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> validate_length(:title, min: 1, max: 64)
  end
end
