defmodule LiveBetting.Schema.Email do
  use Ecto.Schema

  import Ecto.Changeset
  alias LiveBetting.Schema.User

  schema "emails" do
    field :subject, :string
    field :content, :string
    field :is_bulk, :boolean, virtual: true, default: false
    many_to_many :user, User, join_through: "users_emails", on_replace: :delete
    timestamps(type: :utc_datetime)
  end

  def email_changeset(email, attrs \\ %{}, _opts \\ []) do
    email
    |> cast(attrs, [:subject, :content, :user_id, :is_bulk])
    |> cast_assoc(:users, with: &User.user_changeset/2)
    |> validate_required([:subject, :content])
  end

  def changeset_update_contacts(email, users, changes) do
    email
    |> cast(changes, [:subject, :content])
    |> put_assoc(:users, users)
  end
end