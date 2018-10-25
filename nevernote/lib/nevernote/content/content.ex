defmodule Nevernote.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias Nevernote.Repo

  alias Nevernote.Content.Blocknote

  @doc """
  Returns the list of blocknotes.

  ## Examples

      iex> list_blocknotes()
      [%Blocknote{}, ...]

  """
  def list_blocknotes do
    Blocknote |> Repo.all() |> Repo.preload([:notes])
  end

  @doc """
  Gets a single blocknote.

  Raises `Ecto.NoResultsError` if the Blocknote does not exist.

  ## Examples

      iex> get_blocknote!(123)
      %Blocknote{}

      iex> get_blocknote!(456)
      ** (Ecto.NoResultsError)

  """
  def get_blocknote!(id),
    do: Blocknote |> Repo.get!(id) |> Repo.preload([:notes])

  @doc """
  Creates a blocknote.

  ## Examples

      iex> create_blocknote(%{field: value})
      {:ok, %Blocknote{}}

      iex> create_blocknote(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_blocknote(attrs \\ %{}) do
    %Blocknote{}
    |> Blocknote.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a blocknote.

  ## Examples

      iex> update_blocknote(blocknote, %{field: new_value})
      {:ok, %Blocknote{}}

      iex> update_blocknote(blocknote, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_blocknote(%Blocknote{} = blocknote, attrs) do
    blocknote
    |> Blocknote.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Blocknote.

  ## Examples

      iex> delete_blocknote(blocknote)
      {:ok, %Blocknote{}}

      iex> delete_blocknote(blocknote)
      {:error, %Ecto.Changeset{}}

  """
  def delete_blocknote(%Blocknote{} = blocknote) do
    Repo.delete(blocknote)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking blocknote changes.

  ## Examples

      iex> change_blocknote(blocknote)
      %Ecto.Changeset{source: %Blocknote{}}

  """
  def change_blocknote(%Blocknote{} = blocknote) do
    Blocknote.changeset(blocknote, %{})
  end

  alias Nevernote.Content.Note

  @doc """
  Returns the list of notes.

  ## Examples

      iex> list_notes()
      [%Note{}, ...]

  """
  def list_notes do
    Repo.all(Note)
  end

  @doc """
  Gets a single note.

  Raises `Ecto.NoResultsError` if the Note does not exist.

  ## Examples

      iex> get_note!(123)
      %Note{}

      iex> get_note!(456)
      ** (Ecto.NoResultsError)

  """
  def get_note!(id), do: Repo.get!(Note, id)

  @doc """
  Creates a note.

  ## Examples

      iex> create_note(%{field: value})
      {:ok, %Note{}}

      iex> create_note(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_note(attrs \\ %{}) do
    %Note{}
    |> Note.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a note.

  ## Examples

      iex> update_note(note, %{field: new_value})
      {:ok, %Note{}}

      iex> update_note(note, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_note(%Note{} = note, attrs) do
    note
    |> Note.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Note.

  ## Examples

      iex> delete_note(note)
      {:ok, %Note{}}

      iex> delete_note(note)
      {:error, %Ecto.Changeset{}}

  """
  def delete_note(%Note{} = note) do
    Repo.delete(note)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking note changes.

  ## Examples

      iex> change_note(note)
      %Ecto.Changeset{source: %Note{}}

  """
  def change_note(%Note{} = note) do
    Note.changeset(note, %{})
  end
end
