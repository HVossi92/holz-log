defmodule HolzLogWeb.NoteController do
  use HolzLogWeb, :controller

  alias HolzLog.Log
  alias HolzLog.Log.Note

  def index(conn, _params) do
    search = conn.query_params["search"]
    category = conn.query_params["category_id"]

    category_id =
      case category do
        nil -> nil
        _ -> String.to_integer(category)
      end

    notes = Log.list_notes(search, category_id)
    categories = Log.list_categories()
    render(conn, :index, notes: notes, categories: categories)
  end

  def new(conn, _params) do
    changeset = Log.change_note(%Note{})
    categories = Log.list_categories() |> Enum.map(fn c -> {c.title, c.id} end)
    render(conn, :new, changeset: changeset, categories: categories)
  end

  def create(conn, %{"note" => note_params}) do
    case Log.create_note(note_params) do
      {:ok, note} ->
        conn
        |> put_flash(:info, "Note created successfully.")
        |> redirect(to: ~p"/notes/#{note}")

      {:error, %Ecto.Changeset{} = changeset} ->
        categories = Log.list_categories() |> Enum.map(fn c -> {c.title, c.id} end)
        render(conn, :new, changeset: changeset, categories: categories)
    end
  end

  def show(conn, %{"id" => id}) do
    note = Log.get_note!(id)
    render(conn, :show, note: note)
  end

  def edit(conn, %{"id" => id}) do
    note = Log.get_note!(id)
    changeset = Log.change_note(note)
    categories = Log.list_categories() |> Enum.map(fn c -> {c.title, c.id} end)

    render(conn, :edit,
      note: note,
      changeset: changeset,
      categories: categories,
      selected_categories: note.categories |> Enum.map(fn c -> c.id end)
    )

    # changeset = Log.change_note(%Note{})
    # categories = Log.list_categories() |> Enum.map(fn c -> {c.title, c.id} end)
    # render(conn, :new, changeset: changeset, categories: categories)
  end

  def update(conn, %{"id" => id, "note" => note_params}) do
    note = Log.get_note!(id)

    case Log.update_note(note, note_params) do
      {:ok, note} ->
        conn
        |> put_flash(:info, "Note updated successfully.")
        |> redirect(to: ~p"/notes/#{note}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, note: note, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    note = Log.get_note!(id)
    {:ok, _note} = Log.delete_note(note)

    conn
    |> put_flash(:info, "Note deleted successfully.")
    |> redirect(to: ~p"/notes")
  end
end
