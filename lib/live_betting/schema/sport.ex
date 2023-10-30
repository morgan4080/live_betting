defmodule LiveBetting.Schema.Sport do
  use Ecto.Schema

  import Ecto.Changeset

  schema "sports" do
    field :name, :string
    field :logo_url, :string
    field :description, :string

    has_many :teams, LiveBetting.Schema.Team
    has_many :events, LiveBetting.Schema.Event
  end

  def sport_changeset(sport, params \\ %{}, opts \\ []) do
    sport
    |> cast(params, [:name, :description, :logo_url])
    |> validate_required([:name, :description, :logo_url])
    |> maybe_validate_unique_name(opts)
  end

  def maybe_validate_unique_name(changeset, opts) do
    if Keyword.get(opts, :validate_name, true) do
      changeset
      |> unsafe_validate_unique(:name, LiveBetting.Repo)
      |> unique_constraint(:name)
    else
      changeset
    end
  end
end
