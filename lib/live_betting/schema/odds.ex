defmodule LiveBetting.Schema.Odds do
  use Ecto.Schema

  import Ecto.Changeset

  schema "odds" do
    field :win, :float
    field :draw, :float
    field :loss, :float

    belongs_to :event, LiveBetting.Schema.Event
  end

  def odds_changeset(odds, params \\ %{}, _opts \\ []) do
    odds
    |> cast(params, [:win, :draw, :loss])
    |> validate_required([:win, :draw, :loss])
  end
end