defmodule LiveBetting.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications

  # Application.get_all_env(:live_betting)
  # to show all environment variables

  @moduledoc false

  use Application

  # The start/2 callback has to spawn and link a supervisor and return
  # {:ok, pid} or {:ok, pid, state},
  # where pid is the PID of the supervisor, and state is an optional application state.
  # args is the second element of the tuple given to the :mod option in mix.exs.

  # The type argument passed to start/2 is usually
  # :normal unless in a distributed setup where application takeovers and failovers are configured.

  @impl true
  def start(_type, _args) do
    children = [
      LiveBettingWeb.Telemetry,
      LiveBetting.Repo,
      {DNSCluster, query: Application.get_env(:live_betting, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LiveBetting.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LiveBetting.Finch},
      # Start a worker by calling: LiveBetting.Worker.start_link(arg)
      # {LiveBetting.Worker, arg},
      # Start to serve requests, typically the last entry
      LiveBettingWeb.Endpoint,
      {Oban, Application.fetch_env!(:live_betting, Oban)}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveBetting.Supervisor]
    # returns {:ok, pid} or {:ok, pid, state}
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveBettingWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
