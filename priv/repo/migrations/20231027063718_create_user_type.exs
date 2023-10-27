defmodule LiveBetting.Repo.Migrations.CreateUserType do
  use Ecto.Migration

  def change do
    create table(:user_types) do
      add :type_name, :string
    end
  end
end
