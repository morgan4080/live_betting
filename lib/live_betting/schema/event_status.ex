defmodule LiveBetting.Schema.EventStatus do
  use Ecto.Schema

  import Ecto.Changeset
  alias LiveBetting.Schema.Event

  schema "event_status" do
    field :name, :string

    has_many :events, Event, on_delete: :delete_all, on_replace: :delete
  end

  def event_status_changeset(event_status, params \\ %{}, _opts \\ []) do
    event_status
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end