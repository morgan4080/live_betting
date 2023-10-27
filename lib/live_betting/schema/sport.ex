defmodule LiveBetting.Schema.Sport do
  use Ecto.Schema

  import Ecto.Changeset
  alias LiveBetting.Schema.{Team, Event}

  schema "sports" do
    field :name, :string
    field :logo_url, :string
    field :description, :string

    has_many :teams, Team, on_delete: :delete_all, on_replace: :delete
    has_many :events, Event, on_delete: :delete_all, on_replace: :delete
  end


  def sport_changeset(sport, params \\ %{}, opts \\ []) do
    sport
    |> cast(params, [:name, :logo_url, :description])
    |> validate_required([:name, :logo_url, :description])
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