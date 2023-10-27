defmodule LiveBetting.Repo.Migrations.CreateUsersEmails do
  use Ecto.Migration

  def change do
    create table(:users_emails) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :email_id, references(:emails, on_delete: :delete_all), null: false
    end

    create index(:users_emails, [:user_id, :email_id])
  end
end
