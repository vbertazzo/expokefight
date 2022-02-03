import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :expokefight, Expokefight.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "expokefight_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :expokefight, ExpokefightWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "uDaAXPiLqhoQQs3En6GjkEnytkhnDtfvFeWtPl5QPq2KJudZHxn/qRgFjPrMhRSU",
  server: false

# In test we don't send emails.
config :expokefight, Expokefight.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Enable bypass debug log
config :bypass, enable_debug_log: true

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
