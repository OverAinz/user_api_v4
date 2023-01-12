# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :user_api_v4,
  ecto_repos: [UserApiV4.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :user_api_v4, UserApiV4Web.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: UserApiV4Web.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: UserApiV4.PubSub,
  live_view: [signing_salt: "Gz/8ERKC"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

#config guardian
config :user_api_v4, UserApiV4Web.Auth.Guardian,
  issuer: "user_api_v4",
  secret_key: "juei/E1l/hBOCuOPzmTHrZjvoMBuXTEY53D1YV2MJ9G0FlpBXjkbTTZrSNNNkrj+"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
