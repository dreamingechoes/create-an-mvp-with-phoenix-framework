defmodule Nevernote.Content.Blocknote do
  use Ecto.Schema

  import Ecto.Changeset

  alias Nevernote.Accounts.User
  alias Nevernote.Content.Note

  schema "blocknotes" do
    field(:title, :string)

    timestamps()

    # Associations
    belongs_to(:user, User)
    has_many(:notes, Note, on_delete: :delete_all)
  end

  @doc false
  def changeset(blocknote, attrs) do
    blocknote
    |> cast(attrs, [:title, :user_id])
    |> validate_required([:title])
    |> cast_assoc(:user)
  end
end
