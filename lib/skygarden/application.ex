defmodule Skygarden.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SkygardenWeb.Telemetry,
      Skygarden.Repo,
      {DNSCluster, query: Application.get_env(:skygarden, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Skygarden.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Skygarden.Finch},
      # Start a worker by calling: Skygarden.Worker.start_link(arg)
      # {Skygarden.Worker, arg},
      # Start to serve requests, typically the last entry
      SkygardenWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Skygarden.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SkygardenWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
