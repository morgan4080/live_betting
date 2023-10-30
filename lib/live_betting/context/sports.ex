defmodule LiveBetting.Context.Sports do
  alias LiveBetting.Schema.Sport
  alias LiveBetting.Repo

  def list_sports() do
    Repo.all(Sport)
  end

  def create_sport(changeset) do
    Repo.insert!(changeset)
  end
end
