defmodule HolzLog.LogTest do
  use HolzLog.DataCase

  alias HolzLog.Log

  describe "notes" do
    alias HolzLog.Log.Note

    import HolzLog.LogFixtures

    @invalid_attrs %{title: nil, body: nil}

    test "list_notes/0 returns all notes" do
      note = note_fixture()
      assert Log.list_notes() == [note]
    end

    test "get_note!/1 returns the note with given id" do
      note = note_fixture()
      assert Log.get_note!(note.id) == note
    end

    test "create_note/1 with valid data creates a note" do
      valid_attrs = %{title: "some title", body: "some body"}

      assert {:ok, %Note{} = note} = Log.create_note(valid_attrs)
      assert note.title == "some title"
      assert note.body == "some body"
    end

    test "create_note/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Log.create_note(@invalid_attrs)
    end

    test "update_note/2 with valid data updates the note" do
      note = note_fixture()
      update_attrs = %{title: "some updated title", body: "some updated body"}

      assert {:ok, %Note{} = note} = Log.update_note(note, update_attrs)
      assert note.title == "some updated title"
      assert note.body == "some updated body"
    end

    test "update_note/2 with invalid data returns error changeset" do
      note = note_fixture()
      assert {:error, %Ecto.Changeset{}} = Log.update_note(note, @invalid_attrs)
      assert note == Log.get_note!(note.id)
    end

    test "delete_note/1 deletes the note" do
      note = note_fixture()
      assert {:ok, %Note{}} = Log.delete_note(note)
      assert_raise Ecto.NoResultsError, fn -> Log.get_note!(note.id) end
    end

    test "change_note/1 returns a note changeset" do
      note = note_fixture()
      assert %Ecto.Changeset{} = Log.change_note(note)
    end
  end

  describe "categories" do
    alias HolzLog.Log.Category

    import HolzLog.LogFixtures

    @invalid_attrs %{name: nil}

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Log.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Log.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Category{} = category} = Log.create_category(valid_attrs)
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Log.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Category{} = category} = Log.update_category(category, update_attrs)
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Log.update_category(category, @invalid_attrs)
      assert category == Log.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Log.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Log.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Log.change_category(category)
    end
  end
end
