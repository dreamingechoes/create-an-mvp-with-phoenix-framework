defmodule NevernoteWeb.BlocknoteControllerTest do
  use NevernoteWeb.ConnCase

  alias Nevernote.Accounts
  alias Nevernote.Content

  @create_attrs %{title: "some title", user_id: 1}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  def fixture(:user) do
    {:ok, user} =
      Accounts.create_user(%{email: "some@email.com", password: "some password"})

    user
  end

  def fixture(:blocknote, user) do
    {:ok, blocknote} =
      Content.create_blocknote(Map.put(@create_attrs, :user_id, user.id))

    blocknote
  end

  describe "index" do
    test "lists all blocknotes", %{conn: conn, user: user} do
      conn = get(log_in(user), blocknote_path(conn, :index))
      assert html_response(conn, 200) =~ "List of blocknotes"
    end
  end

  describe "new blocknote" do
    test "renders form", %{conn: conn, user: user} do
      conn = get(log_in(user), blocknote_path(conn, :new))
      assert html_response(conn, 200) =~ "New blocknote"
    end
  end

  describe "create blocknote" do
    setup [:create_blocknote]

    test "redirects to show when data is valid", %{
      conn: conn,
      user: user,
      user: user
    } do
      conn =
        post(log_in(user), blocknote_path(conn, :create),
          blocknote: Map.put(@create_attrs, :user_id, user.id)
        )

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == blocknote_path(conn, :show, id)

      conn = get(log_in(user), blocknote_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show blocknote"
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn =
        post(log_in(user), blocknote_path(conn, :create),
          blocknote: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "New blocknote"
    end
  end

  describe "edit blocknote" do
    setup [:create_blocknote]

    test "renders form for editing chosen blocknote", %{
      conn: conn,
      user: user,
      blocknote: blocknote
    } do
      conn = get(log_in(user), blocknote_path(conn, :edit, blocknote))
      assert html_response(conn, 200) =~ "Edit blocknote"
    end
  end

  describe "update blocknote" do
    setup [:create_blocknote]

    test "redirects when data is valid", %{
      conn: conn,
      user: user,
      blocknote: blocknote
    } do
      conn =
        put(log_in(user), blocknote_path(conn, :update, blocknote),
          blocknote: @update_attrs
        )

      assert redirected_to(conn) == blocknote_path(conn, :show, blocknote)

      conn = get(log_in(user), blocknote_path(conn, :show, blocknote))
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{
      conn: conn,
      user: user,
      blocknote: blocknote
    } do
      conn =
        put(log_in(user), blocknote_path(conn, :update, blocknote),
          blocknote: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit blocknote"
    end
  end

  describe "delete blocknote" do
    setup [:create_blocknote]

    test "deletes chosen blocknote", %{
      conn: conn,
      user: user,
      blocknote: blocknote
    } do
      conn = delete(log_in(user), blocknote_path(conn, :delete, blocknote))
      assert redirected_to(conn) == blocknote_path(conn, :index)
    end
  end

  defp create_blocknote(_) do
    user = fixture(:user)
    blocknote = fixture(:blocknote, user)

    {:ok, user: user, blocknote: blocknote}
  end
end
