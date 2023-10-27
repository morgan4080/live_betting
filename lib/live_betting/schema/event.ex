defmodule LiveBetting.Schema.Event do
  use Ecto.Schema

  schema "events" do
    field :occurs_on, :utc_datetime
    field :location, :string

    has_one :odd, LiveBetting.Schema.Odds

    belongs_to :sport, LiveBetting.Schema.Sport
    belongs_to :event_status, LiveBetting.Schema.EventStatus

    many_to_many :teams, LiveBetting.Schema.Team, join_through: "teams_events"
  end

end