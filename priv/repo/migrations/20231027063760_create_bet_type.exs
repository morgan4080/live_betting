defmodule LiveBetting.Repo.Migrations.CreateBetType do
  use Ecto.Migration

  def change do
    create table(:bet_types) do
      add :name, :string, null: false
    end

    create unique_index(:bet_types, [:name])
  end
end
