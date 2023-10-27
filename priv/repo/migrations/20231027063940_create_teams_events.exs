defmodule LiveBetting.Repo.Migrations.CreateTeamsEvents do
  use Ecto.Migration

  def change do
    create table(:teams_events) do
      add :team_id, references(:teams, on_delete: :delete_all), null: false
      add :event_id, references(:events, on_delete: :delete_all), null: false
    end

    create index(:teams_events, [:team_id, :event_id])
  end
end
