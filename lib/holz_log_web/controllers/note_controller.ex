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

    title =
      if category_id !== nil and category_id > -1,
        do: "Notes in #{Enum.find(categories, &(&1.id == category_id)).title}",
        else: "All Notes"

    meta_desc =
      if search, do: "Search results for '#{search}'", else: "Browse all your notes and logs"

    conn
    |> assign(:page_title, title)
    |> assign(:meta_description, "#{meta_desc} - Holz Log Notes Management")
    |> assign(:meta_keywords, "notes, logs, organization, holz log")
    |> assign(:canonical_url, url(~p"/notes"))
    |> assign(:search_value, search)
    |> render(:index, notes: notes, categories: categories)
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

    # Create a meaningful title and description from the note content
    title = "Note: #{String.slice(note.title || "", 0, 60)}"

    # Get first 160 chars of content for meta description
    content_preview =
      note.content
      |> String.slice(0, 160)
      |> String.replace(~r/\s+/, " ")
      |> String.trim()

    # Generate keywords from categories
    keywords =
      note.categories
      |> Enum.map_join(", ", fn c -> c.title end)
      |> then(fn cat_str -> "notes, #{cat_str}, holz log" end)

    conn
    |> assign(:page_title, title)
    |> assign(:meta_description, content_preview)
    |> assign(:meta_keywords, keywords)
    |> assign(:canonical_url, url(~p"/notes/#{note}"))
    |> render(:show, note: note)
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
