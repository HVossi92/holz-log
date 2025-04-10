defmodule HolzLog.Log.Note do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notes" do
    field :title, :string
    field :body, :string
    many_to_many :categories, HolzLog.Log.Category, join_through: "note_has_category"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
    |> validate_length(:title, min: 1, max: 256)
    |> validate_length(:body, max: 32786)
  end
end
