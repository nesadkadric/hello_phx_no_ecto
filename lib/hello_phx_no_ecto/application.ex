defmodule HelloPhxNoEcto.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HelloPhxNoEctoWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:hello_phx_no_ecto, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: HelloPhxNoEcto.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: HelloPhxNoEcto.Finch},
      # Start a worker by calling: HelloPhxNoEcto.Worker.start_link(arg)
      # {HelloPhxNoEcto.Worker, arg},
      # Start to serve requests, typically the last entry
      HelloPhxNoEctoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloPhxNoEcto.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HelloPhxNoEctoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
