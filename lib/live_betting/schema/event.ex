defmodule LiveBetting.Schema.Event do
  use Ecto.Schema

  alias LiveBetting.Schema.{User, Sport, EventStatus}

  schema "events" do
    field :occurs_on, :date, null: false
    field :location, :string, null: false

    belongs_to :user, Sport
    belongs_to :user, EventStatus
  end

end