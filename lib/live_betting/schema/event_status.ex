defmodule LiveBetting.Schema.EventStatus do
  use Ecto.Schema

  import Ecto.Changeset

  schema "event_statuses" do
    field :name, :string

    has_many :events, LiveBetting.Schema.Event
  end

  def event_status_changeset(event_status, params \\ %{}, _opts \\ []) do
    event_status
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end