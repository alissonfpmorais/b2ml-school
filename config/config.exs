# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :b2ml,
  ecto_repos: [B2ml.Repo]

# Configures the endpoint
config :b2ml, B2mlWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WWbUhMz3QY+jaC4FwzVFWSoClg8l4rHM+7Dr/AxHvSkqicLNUTNy+NH7Qm6UjXAY",
  render_errors: [view: B2mlWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: B2ml.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "D20QxfHN"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
