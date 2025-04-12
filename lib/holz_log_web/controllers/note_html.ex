defmodule HolzLogWeb.NoteHTML do
  use HolzLogWeb, :html

  embed_templates "note_html/*"

  @doc """
  Renders a note form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :categories, :list, required: true
  attr :selected_categories, :list, required: false, default: []

  def note_form(assigns)
end
