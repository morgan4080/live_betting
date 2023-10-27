defmodule LiveBetting.Schema.BetType do
  use Ecto.Schema

  schema "bet_type" do
    field :type, :string # win, lose, draw

    has_many :bets, LiveBetting.Schema.Bet
  end
end