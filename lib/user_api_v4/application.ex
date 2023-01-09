defmodule UserApiV4.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      UserApiV4.Repo,
      # Start the Telemetry supervisor
      UserApiV4Web.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: UserApiV4.PubSub},
      # Start the Endpoint (http/https)
      UserApiV4Web.Endpoint
      # Start a worker by calling: UserApiV4.Worker.start_link(arg)
      # {UserApiV4.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: UserApiV4.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    UserApiV4Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
