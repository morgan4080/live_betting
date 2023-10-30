defmodule LiveBetting.Schema.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :occurs_on, :utc_datetime
    field :location, :string

    has_one :odd, LiveBetting.Schema.Odds

    belongs_to :sport, LiveBetting.Schema.Sport
    belongs_to :event_status, LiveBetting.Schema.EventStatus

    many_to_many :teams, LiveBetting.Schema.Team, join_through: "teams_events"
  end

  def event_changeset(event, params \\ %{}, _opts \\ []) do
    event
    |> cast(params, [:occurs_on, :location, :sport_id, :event_status_id])
    |> validate_required([:occurs_on, :location, :sport_id, :event_status_id])
  end
end
