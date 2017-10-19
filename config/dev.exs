use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :fpbackend, FpbackendWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []


# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :fpbackend, Fpbackend.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "fpb",
  password: "fpb",
  database: "fpbackend_dev",
  hostname: "localhost",
  pool_size: 10

config :fpbackend, :frontend_domains_allowed, "*"

config :fpbackend, Fpbackend.Guardian,
  issuer: "freaksparty",
  secret_key: "qfXdFLgMfCeGf584L8k6lLbwpJuIBkjsHrMVCP8pCHhAdple0BnTcel5UKKLTY+0",
  token_ttl: %{
    "refresh" => {30, :weeks},
    "access" => {3, :hours}
  }
