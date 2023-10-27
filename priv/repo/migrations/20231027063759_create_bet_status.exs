defmodule LiveBetting.Repo.Migrations.CreateBetStatus do
  use Ecto.Migration

  def change do
    create table(:bet_status) do
      add :name, :string, null: false
    end
  end
end
