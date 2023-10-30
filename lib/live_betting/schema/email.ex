defmodule LiveBetting.Schema.Email do
  use Ecto.Schema

  import Ecto.Changeset
  alias LiveBetting.Schema.User

  schema "emails" do
    field :subject, :string
    field :content, :string
    many_to_many :user, User, join_through: "users_emails"
    timestamps(type: :utc_datetime)
  end

  def email_changeset(email, attrs \\ %{}, _opts \\ []) do
    email
    |> cast(attrs, [:subject, :content])
    |> cast_assoc(:users, with: &User.user_changeset/2)
    |> validate_required([:subject, :content])
  end

  def changeset_update_users(email, users, changes) do
    email
    |> cast(changes, [:subject, :content])
    |> put_assoc(:users, users)
  end
end
