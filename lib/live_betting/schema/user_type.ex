defmodule LiveBetting.Schema.UserType do
  use Ecto.Schema

  import Ecto.Changeset
  alias LiveBetting.Schema.User

  schema "user_types" do
    field :type_name, :string
    has_many :users, User
  end

  def type_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:type_name])
    |> validate_required([:type_name])
  end
end
