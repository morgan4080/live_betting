defmodule LiveBetting.Repo.Migrations.CreateSport do
  use Ecto.Migration

  def change do
    create table(:sports) do
      add :name, :string, null: false
      add :logo_url, :bytea, null: false
      add :description, :string, null: false
    end
  end
end
