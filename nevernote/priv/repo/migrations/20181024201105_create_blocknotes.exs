defmodule Nevernote.Repo.Migrations.CreateBlocknotes do
  use Ecto.Migration

  def change do
    create table(:blocknotes) do
      add(:title, :string, null: false)
      add(:user_id, references(:users, on_delete: :delete_all))

      timestamps()
    end

    create(index(:blocknotes, [:user_id]))
  end
end
