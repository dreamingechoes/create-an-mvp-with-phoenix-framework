defmodule Nevernote.Content.Note do
  use Ecto.Schema

  import Ecto.Changeset

  alias Nevernote.Content.Blocknote

  schema "notes" do
    field(:description, :string)
    field(:title, :string)

    timestamps()

    # Associations
    belongs_to(:blocknote, Blocknote)
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:title, :description, :blocknote_id])
    |> validate_required([:title])
    |> cast_assoc(:blocknote)
  end
end
