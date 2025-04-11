defmodule HolzLogWeb.CategoryHTML do
  import HolzLogWeb.CategoriesTable
  use HolzLogWeb, :html

  embed_templates "category_html/*"

  @doc """
  Renders a category form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def category_form(assigns)
end
