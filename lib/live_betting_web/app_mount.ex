defmodule LiveBetting.AppMount do
  use LiveBettingWeb, :verified_routes

  def on_mount(:mount_current_path, _params, session, socket) do
    {:cont, Phoenix.Component.assign(socket, :current_path, session["current_path"])}
  end
end
