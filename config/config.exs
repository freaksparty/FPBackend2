# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :fpbackend,
  ecto_repos: [Fpbackend.Repo]

# Configures the endpoint
config :fpbackend, FpbackendWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "J6FmWiIT4y21W0wJkuZsx31xPSzbRP5K8TSriO9BwdaJDxXs0yabyA0uBN+FegIt",
  render_errors: [view: FpbackendWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Fpbackend.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian_db, GuardianDb,
  repo: Fpbackend.Repo,
  schema_name: "auth_tokens", 
  sweep_interval: 60

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
