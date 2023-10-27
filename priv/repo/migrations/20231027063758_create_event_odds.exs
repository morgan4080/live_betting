defmodule LiveBetting.Repo.Migrations.CreateEventOdds do
  use Ecto.Migration

  def change do
    create table(:event_odds) do
      add :event_id, references(:events, on_delete: :delete_all), null: false
      add :win, :float, null: false
      add :draw, :float, null: false
      add :loss, :float, null: false
    end

    create index(:event_odds, [:event_id])
  end
end
