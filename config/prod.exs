use Mix.Config

config :fpbackend, FpbackendWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: "dev-fpbackend.herokuapp.com", port: 80],
  cache_static_manifest: "priv/static/manifest.json",
  secret_key_base: Map.fetch!(System.get_env(), "SECRET_KEY_BASE")

# Do not print debug messages in production
config :logger, level: :info

config :fpbackend, Fpbackend.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

config :fpbackend, :frontend_domains_allowed, Map.fetch!(System.get_env(), "FRONTEND_DOMAINS")
