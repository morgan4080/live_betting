defmodule LiveBetting.Repo.Migrations.CreateBet do
  use Ecto.Migration

  def change do
    create table(:bets) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :event_id, references(:events, on_delete: :delete_all), null: false
      add :bet_type_id, references(:bet_types, on_delete: :delete_all), null: false # win, lose, draw
      add :bet_state_id, references(:bet_states, on_delete: :delete_all), null: false # pending, won, lost
      add :bet_amount, :float, null: false
      add :odd, :float, null: false
    end

    create index(:bets, [:user_id, :event_id, :bet_type_id, :bet_state_id])
  end
end
