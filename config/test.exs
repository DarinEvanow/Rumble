use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :rumble, RumbleWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :rumble, Rumble.Repo,
  username: "postgres",
  password: "postgres",
  database: "rumble_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Config Comeonin hashing to speed up our authentication tests
config :pbkdf2_elixir, :rounds, 1
