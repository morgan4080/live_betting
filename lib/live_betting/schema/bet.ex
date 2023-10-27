defmodule LiveBetting.Schema.Bet do
  use Ecto.Schema

  schema "bets" do
    field :bet_amount, :float
    field :odd, :float

    belongs_to :user, LiveBetting.Schema.User
    belongs_to :event, LiveBetting.Schema.Event
    belongs_to :bet_type, LiveBetting.Schema.BetType
    belongs_to :bet_state, LiveBetting.Schema.BetState
  end

end