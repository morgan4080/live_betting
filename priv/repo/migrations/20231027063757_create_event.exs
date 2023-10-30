defmodule LiveBetting.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :sport_id, references(:sports, on_delete: :delete_all), null: false
      add :event_status_id, references(:event_status, on_delete: :delete_all), null: false
      add :odd, :map, null: false
      add :occurs_on, :utc_datetime, null: false
      add :location, :string, null: false
    end

    create index(:events, [:sport_id, :event_status_id])
  end
end
