defmodule LiveBetting.Repo.Migrations.CreateStatus do
  use Ecto.Migration

  def change do
    create table(:event_status) do
      add :name, :string, null: false
    end

    create unique_index(:event_status, [:name])
  end
end
