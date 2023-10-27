defmodule LiveBetting.Repo.Migrations.CreateOdds do
  use Ecto.Migration

  def change do
    create table(:odds) do
      add :event_id, references(:events, on_delete: :delete_all), null: false
      add :win, :float, null: false
      add :draw, :float, null: false
      add :loss, :float, null: false
    end

    create index(:odds, [:event_id])
  end
end
