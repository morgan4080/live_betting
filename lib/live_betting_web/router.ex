defmodule LiveBettingWeb.Router do
  use LiveBettingWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {LiveBettingWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :set_path
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveBettingWeb do
    pipe_through :browser

    live_session :app_mounted, on_mount: [
      {LiveBetting.AppMount, :mount_current_path}
    ], root_layout: {LiveBettingWeb.Layouts, :root} do
      live "/", HomeLive, :index
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveBettingWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:live_betting, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: LiveBettingWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  defp set_path(conn, _opts) do
    Plug.Conn.put_session(conn, :current_path, conn.request_path)
  end
end
