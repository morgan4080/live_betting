defmodule LiveBetting.Schema.Team do
  use Ecto.Schema

  import Ecto.Changeset

  schema "teams" do
    field :team_name, :string
    field :logo_url, :string
    field :location, :string

    belongs_to :sport, LiveBetting.Schema.Sport
    many_to_many :events, LiveBetting.Schema.Event, join_through: "teams_events"
  end


  def team_changeset(team, params \\ %{}, opts \\ []) do
    team
    |> cast(params, [:team_name, :logo_url, :location])
    |> validate_required([:team_name, :logo_url, :location])
    |> maybe_validate_unique_team_name(opts)
  end

  def maybe_validate_unique_team_name(changeset, opts) do
    if Keyword.get(opts, :validate_team_name, true) do
      changeset
      |> unsafe_validate_unique(:team_name, LiveBetting.Repo)
      |> unique_constraint(:team_name)
    else
      changeset
    end
  end

end