defmodule NevernoteWeb.NoteController do
  use NevernoteWeb, :controller

  alias Nevernote.Content
  alias Nevernote.Content.Note

  def new(conn, %{"blocknote_id" => blocknote_id}) do
    changeset = Content.change_note(%Note{blocknote_id: blocknote_id})
    render(conn, "new.html", changeset: changeset, blocknote_id: blocknote_id)
  end

  def create(conn, %{"note" => note_params}) do
    case Content.create_note(note_params) do
      {:ok, note} ->
        conn
        |> put_flash(:info, "Note created successfully.")
        |> redirect(to: blocknote_path(conn, :show, note.blocknote_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html",
          changeset: changeset,
          blocknote_id: note_params["blocknote_id"]
        )
    end
  end

  def edit(conn, %{"id" => id}) do
    note = Content.get_note!(id)
    changeset = Content.change_note(note)

    render(conn, "edit.html",
      note: note,
      changeset: changeset,
      blocknote_id: note.blocknote_id
    )
  end

  def update(conn, %{"id" => id, "note" => note_params}) do
    note = Content.get_note!(id)

    case Content.update_note(note, note_params) do
      {:ok, note} ->
        conn
        |> put_flash(:info, "Note updated successfully.")
        |> redirect(to: blocknote_path(conn, :show, note.blocknote_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html",
          note: note,
          changeset: changeset,
          blocknote_id: note.blocknote_id
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    note = Content.get_note!(id)
    {:ok, note} = Content.delete_note(note)

    conn
    |> put_flash(:info, "Note deleted successfully.")
    |> redirect(to: blocknote_path(conn, :show, note.blocknote_id))
  end
end
