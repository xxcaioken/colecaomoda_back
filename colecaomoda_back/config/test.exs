import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :colecaomoda_back, ColecaomodaBack.Repo,
  database: Path.expand("../colecaomoda_back_test.db", __DIR__),
  pool_size: 5,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :colecaomoda_back, ColecaomodaBackWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "KLub9Im5arGLVbgszyBzLw7JV8ZdklFCqZ908nOhQFyxApNg5TFA+XRMxxvO54j9",
  server: false

# In test we don't send emails
config :colecaomoda_back, ColecaomodaBack.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
