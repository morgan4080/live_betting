defmodule LiveBetting.Schema.UserJournal do
  use Ecto.Schema

  schema "users_journals" do
    field :particulars, :string
    field :debit, :float
    field :credit, :float

    belongs_to :user, LiveBetting.Schema.User
    timestamps(updated_at: false)
  end

end