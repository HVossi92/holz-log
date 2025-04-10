defmodule HolzLog.LogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HolzLog.Log` context.
  """

  @doc """
  Generate a note.
  """
  def note_fixture(attrs \\ %{}) do
    {:ok, note} =
      attrs
      |> Enum.into(%{
        body: "some body",
        title: "some title"
      })
      |> HolzLog.Log.create_note()

    note
  end

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> HolzLog.Log.create_category()

    category
  end
end
