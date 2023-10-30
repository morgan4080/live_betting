defmodule LiveBetting.Schema.BetType do
  use Ecto.Schema

  schema "bet_type" do
    # win, lose, draw
    field :type, :string

    has_many :bets, LiveBetting.Schema.Bet
  end
end
