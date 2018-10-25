defmodule Nevernote.ContentTest do
  use Nevernote.DataCase

  alias Nevernote.Content

  describe "blocknotes" do
    alias Nevernote.Content.Blocknote

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def blocknote_fixture(attrs \\ %{}) do
      {:ok, blocknote} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_blocknote()

      blocknote |> Nevernote.Repo.preload([:notes])
    end

    test "list_blocknotes/0 returns all blocknotes" do
      blocknote = blocknote_fixture()
      assert Content.list_blocknotes() == [blocknote]
    end

    test "get_blocknote!/1 returns the blocknote with given id" do
      blocknote = blocknote_fixture()
      assert Content.get_blocknote!(blocknote.id) == blocknote
    end

    test "create_blocknote/1 with valid data creates a blocknote" do
      assert {:ok, %Blocknote{} = blocknote} =
               Content.create_blocknote(@valid_attrs)

      assert blocknote.title == "some title"
    end

    test "create_blocknote/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Content.create_blocknote(@invalid_attrs)
    end

    test "update_blocknote/2 with valid data updates the blocknote" do
      blocknote = blocknote_fixture()

      assert {:ok, blocknote} =
               Content.update_blocknote(blocknote, @update_attrs)

      assert %Blocknote{} = blocknote
      assert blocknote.title == "some updated title"
    end

    test "update_blocknote/2 with invalid data returns error changeset" do
      blocknote = blocknote_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Content.update_blocknote(blocknote, @invalid_attrs)

      assert blocknote == Content.get_blocknote!(blocknote.id)
    end

    test "delete_blocknote/1 deletes the blocknote" do
      blocknote = blocknote_fixture()
      assert {:ok, %Blocknote{}} = Content.delete_blocknote(blocknote)

      assert_raise Ecto.NoResultsError, fn ->
        Content.get_blocknote!(blocknote.id)
      end
    end

    test "change_blocknote/1 returns a blocknote changeset" do
      blocknote = blocknote_fixture()
      assert %Ecto.Changeset{} = Content.change_blocknote(blocknote)
    end
  end

  describe "notes" do
    alias Nevernote.Content.Note

    @valid_attrs %{description: "some description", title: "some title"}
    @update_attrs %{
      description: "some updated description",
      title: "some updated title"
    }
    @invalid_attrs %{description: nil, title: nil}

    def note_fixture(attrs \\ %{}) do
      {:ok, note} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_note()

      note
    end

    test "list_notes/0 returns all notes" do
      note = note_fixture()
      assert Content.list_notes() == [note]
    end

    test "get_note!/1 returns the note with given id" do
      note = note_fixture()
      assert Content.get_note!(note.id) == note
    end

    test "create_note/1 with valid data creates a note" do
      assert {:ok, %Note{} = note} = Content.create_note(@valid_attrs)
      assert note.description == "some description"
      assert note.title == "some title"
    end

    test "create_note/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_note(@invalid_attrs)
    end

    test "update_note/2 with valid data updates the note" do
      note = note_fixture()
      assert {:ok, note} = Content.update_note(note, @update_attrs)
      assert %Note{} = note
      assert note.description == "some updated description"
      assert note.title == "some updated title"
    end

    test "update_note/2 with invalid data returns error changeset" do
      note = note_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Content.update_note(note, @invalid_attrs)

      assert note == Content.get_note!(note.id)
    end

    test "delete_note/1 deletes the note" do
      note = note_fixture()
      assert {:ok, %Note{}} = Content.delete_note(note)
      assert_raise Ecto.NoResultsError, fn -> Content.get_note!(note.id) end
    end

    test "change_note/1 returns a note changeset" do
      note = note_fixture()
      assert %Ecto.Changeset{} = Content.change_note(note)
    end
  end
end
