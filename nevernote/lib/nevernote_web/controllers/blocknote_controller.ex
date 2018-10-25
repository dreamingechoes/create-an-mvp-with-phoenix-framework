defmodule NevernoteWeb.BlocknoteController do
  use NevernoteWeb, :controller

  alias Nevernote.Content
  alias Nevernote.Content.Blocknote

  def index(conn, _params) do
    render(conn, "index.html", blocknotes: conn.assigns.current_user.blocknotes)
  end

  def new(conn, _params) do
    changeset = Content.change_blocknote(%Blocknote{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"blocknote" => blocknote_params}) do
    blocknote_params =
      Map.put(blocknote_params, "user_id", conn.assigns.current_user.id)

    case Content.create_blocknote(blocknote_params) do
      {:ok, blocknote} ->
        conn
        |> put_flash(:info, "Blocknote created successfully.")
        |> redirect(to: blocknote_path(conn, :show, blocknote))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    blocknote = Content.get_blocknote!(id)
    render(conn, "show.html", blocknote: blocknote)
  end

  def edit(conn, %{"id" => id}) do
    blocknote = Content.get_blocknote!(id)
    changeset = Content.change_blocknote(blocknote)
    render(conn, "edit.html", blocknote: blocknote, changeset: changeset)
  end

  def update(conn, %{"id" => id, "blocknote" => blocknote_params}) do
    blocknote = Content.get_blocknote!(id)

    case Content.update_blocknote(blocknote, blocknote_params) do
      {:ok, blocknote} ->
        conn
        |> put_flash(:info, "Blocknote updated successfully.")
        |> redirect(to: blocknote_path(conn, :show, blocknote))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", blocknote: blocknote, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    blocknote = Content.get_blocknote!(id)
    {:ok, _blocknote} = Content.delete_blocknote(blocknote)

    conn
    |> put_flash(:info, "Blocknote deleted successfully.")
    |> redirect(to: blocknote_path(conn, :index))
  end
end
