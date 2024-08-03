defmodule Template.Mono.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Template.MonoWeb.Telemetry,
      Template.Mono.Repo,
      {DNSCluster, query: Application.get_env(:template_mono, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Template.Mono.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Template.Mono.Finch},
      # Start a worker by calling: Template.Mono.Worker.start_link(arg)
      # {Template.Mono.Worker, arg},
      # Start to serve requests, typically the last entry
      Template.MonoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Template.Mono.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Template.MonoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
