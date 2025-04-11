defmodule HolzLogWeb.Plugs.FetchCategories do
  @moduledoc """
  Plug to fetch categories for the navigation sidebar.
  """
  import Plug.Conn

  alias HolzLog.Log

  def init(opts), do: opts

  def call(conn, _opts) do
    categories = Log.list_categories()
    assign(conn, :categories, categories)
  end
end
