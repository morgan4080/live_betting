defmodule LiveBetting.Schema.UserJournal do
  use Ecto.Schema

  alias LiveBetting.Schema.User

  schema "users_journals" do
    field :particulars, :string
    field :debit, :float
    field :credit, :float

    belongs_to :user, User
    timestamps(updated_at: false)
  end

end