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
    |> put_assoc(:categories, parse_categories(attrs["categories"] || []))
  end

  defp parse_categories(nil), do: []

  defp parse_categories(category_ids) when is_list(category_ids) do
    category_ids
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&String.to_integer/1)
    |> load_categories()
  end

  defp parse_categories(_), do: []

  defp load_categories(category_ids) do
    HolzLog.Log.list_categories()
    |> Enum.filter(&(&1.id in category_ids))
  end
end
