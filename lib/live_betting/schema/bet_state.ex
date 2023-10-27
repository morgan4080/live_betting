defmodule LiveBetting.Schema.BetState do
  use Ecto.Schema

  schema "bet_states" do
    field :state, :string # pending, won, lost

    has_many :bets, LiveBetting.Schema.Bet
  end
end