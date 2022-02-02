defmodule Expokefight.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Expokefight.Repo,
      # Start the Telemetry supervisor
      ExpokefightWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Expokefight.PubSub},
      # Start the Endpoint (http/https)
      ExpokefightWeb.Endpoint
      # Start a worker by calling: Expokefight.Worker.start_link(arg)
      # {Expokefight.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Expokefight.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExpokefightWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
