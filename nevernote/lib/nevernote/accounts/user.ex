defmodule Nevernote.Accounts.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Nevernote.Content.Blocknote

  schema "users" do
    field(:email, :string)
    field(:password, :string)
    field(:username, :string)

    timestamps()

    # Associations
    has_many(:blocknotes, Blocknote, on_delete: :delete_all)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password])
    |> validate_required([:email, :password])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> generate_encrypted_password()
  end

  defp generate_encrypted_password(%Ecto.Changeset{valid?: true} = changeset) do
    case get_change(changeset, :password) do
      nil ->
        changeset

      password ->
        put_change(
          changeset,
          :password,
          Comeonin.Bcrypt.hashpwsalt(password)
        )
    end
  end

  defp generate_encrypted_password(changeset), do: changeset
end
