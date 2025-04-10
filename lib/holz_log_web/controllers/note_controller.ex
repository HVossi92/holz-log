defmodule HolzLogWeb.NoteController do
  use HolzLogWeb, :controller

  alias HolzLog.Log
  alias HolzLog.Log.Note

  def index(conn, _params) do
    notes = Log.list_notes()
    render(conn, :index, notes: notes)
  end

  def new(conn, _params) do
    changeset = Log.change_note(%Note{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"note" => note_params}) do
    case Log.create_note(note_params) do
      {:ok, note} ->
        conn
        |> put_flash(:info, "Note created successfully.")
        |> redirect(to: ~p"/notes/#{note}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    note = Log.get_note!(id)
    render(conn, :show, note: note)
  end

  def edit(conn, %{"id" => id}) do
    note = Log.get_note!(id)
    changeset = Log.change_note(note)
    render(conn, :edit, note: note, changeset: changeset)
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
