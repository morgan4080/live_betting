defmodule LiveBetting.Repo.Migrations.CreateUsersJournals do
  use Ecto.Migration

  def change do
    create table(:users_journals) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :particulars, :text, null: false
      add :debit, :float, null: false
      add :credit, :float, null: false
      timestamps(updated_at: false)
    end

    create index(:users_journals, [:user_id])
  end
end
