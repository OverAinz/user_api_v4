import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :user_api_v4, UserApiV4.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "database",
  database: "user_api_v4_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :user_api_v4, UserApiV4Web.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "B+W8Z4g1yN0mld3XYf0ZlwI9xSOsc3qkTBTFEL/YlmB8tC0DInC2A+9Q24IF/P0a",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
