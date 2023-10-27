defmodule LiveBetting.Repo.Migrations.CreateBetType do
  use Ecto.Migration

  def change do
    create table(:bet_types) do
      add :type, :string, null: false
    end
  end
end
