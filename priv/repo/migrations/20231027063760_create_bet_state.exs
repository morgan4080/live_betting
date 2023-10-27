defmodule LiveBetting.Repo.Migrations.CreateBetState do
  use Ecto.Migration

  def change do
    create table(:bet_states) do
      add :state, :string, null: false
    end

    create unique_index(:bet_states, [:state])
  end
end
