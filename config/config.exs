# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ipsum,
  ecto_repos: [Ipsum.Repo]

# Configures the endpoint
config :ipsum, IpsumWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QEfLM5g6RWqOTOpO08UozwwrDqCRpxiblKn7TDM4TDvspWRHQoKptUPrqIHOWU/E",
  render_errors: [view: IpsumWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ipsum.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "8OeZc0Gk"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
