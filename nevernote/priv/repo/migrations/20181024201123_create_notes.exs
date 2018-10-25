defmodule Nevernote.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add(:title, :string, null: false)
      add(:description, :text)
      add(:blocknote_id, references(:blocknotes, on_delete: :delete_all))

      timestamps()
    end

    create(index(:notes, [:blocknote_id]))
  end
end
