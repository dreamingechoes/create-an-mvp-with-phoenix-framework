defmodule NevernoteWeb.NoteControllerTest do
  use NevernoteWeb.ConnCase

  alias Nevernote.Accounts
  alias Nevernote.Content

  @create_attrs %{description: "some description", title: "some title"}
  @update_attrs %{
    description: "some updated description",
    title: "some updated title"
  }
  @invalid_attrs %{description: nil, title: nil, blocknote_id: 1}

  def fixture(:blocknote) do
    {:ok, user} =
      Accounts.create_user(%{email: "some@email.com", password: "some password"})

    {:ok, blocknote} =
      Content.create_blocknote(%{title: "some title", user_id: user.id})

    blocknote
  end

  def fixture(:note, blocknote) do
    {:ok, note} =
      Content.create_note(Map.put(@create_attrs, :blocknote_id, blocknote.id))

    note |> Nevernote.Repo.preload([:blocknote])
  end

  describe "new note" do
    setup [:create_note]

    test "renders form", %{
      conn: conn,
      user: user,
      user: user,
      blocknote: blocknote
    } do
      conn =
        get(log_in(user), note_path(conn, :new, blocknote_id: blocknote.id))

      assert html_response(conn, 200) =~ "New note"
    end
  end

  describe "create note" do
    setup [:create_note]

    test "redirects to show when data is valid", %{
      conn: conn,
      user: user,
      blocknote: blocknote
    } do
      conn =
        post(log_in(user), note_path(conn, :create),
          note: Map.put(@create_attrs, :blocknote_id, blocknote.id)
        )

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == blocknote_path(conn, :show, blocknote.id)

      conn = get(log_in(user), blocknote_path(conn, :show, blocknote.id))
      assert html_response(conn, 200) =~ "Show blocknote"
    end

    test "renders errors when data is invalid", %{
      conn: conn,
      user: user,
      user: user
    } do
      conn =
        post(log_in(user), note_path(conn, :create),
          note: Map.put(@invalid_attrs, "blocknote_id", 1)
        )

      assert html_response(conn, 200) =~ "New note"
    end
  end

  describe "edit note" do
    setup [:create_note]

    test "renders form for editing chosen note", %{
      conn: conn,
      user: user,
      user: user,
      note: note
    } do
      conn = get(log_in(user), note_path(conn, :edit, note))
      assert html_response(conn, 200) =~ "Edit note"
    end
  end

  describe "update note" do
    setup [:create_note]

    test "redirects when data is valid", %{
      conn: conn,
      user: user,
      note: note,
      blocknote: blocknote
    } do
      conn =
        put(log_in(user), note_path(conn, :update, note), note: @update_attrs)

      assert redirected_to(conn) == blocknote_path(conn, :show, blocknote.id)

      conn = get(log_in(user), blocknote_path(conn, :show, blocknote.id))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{
      conn: conn,
      user: user,
      user: user,
      note: note
    } do
      conn =
        put(log_in(user), note_path(conn, :update, note), note: @invalid_attrs)

      assert html_response(conn, 200) =~ "Edit note"
    end
  end

  describe "delete note" do
    setup [:create_note]

    test "deletes chosen note", %{
      conn: conn,
      user: user,
      user: user,
      note: note,
      blocknote: blocknote
    } do
      conn = delete(log_in(user), note_path(conn, :delete, note))
      assert redirected_to(conn) == blocknote_path(conn, :show, blocknote.id)
    end
  end

  defp create_note(_) do
    blocknote = fixture(:blocknote)
    note = fixture(:note, blocknote)

    {:ok, note: note, blocknote: blocknote}
  end
end
