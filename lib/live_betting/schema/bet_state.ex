defmodule LiveBetting.Schema.BetState do
  use Ecto.Schema

  schema "bet_states" do
    # pending, won, lost
    field :state, :string

    has_many :bets, LiveBetting.Schema.Bet
  end
end
