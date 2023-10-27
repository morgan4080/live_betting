defmodule LiveBetting.Repo.Migrations.CreateTeam do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :sport_id, references(:sports, on_delete: :delete_all), null: false
      add :team_name, :string, null: false
      add :logo_url, :bytea, null: false
      add :location, :string
    end

    create index(:teams, [:sport_id])
  end
end
