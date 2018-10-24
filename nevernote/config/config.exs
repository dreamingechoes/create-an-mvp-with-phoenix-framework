# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :nevernote,
  ecto_repos: [Nevernote.Repo]

# Configures the endpoint
config :nevernote, NevernoteWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qpP0MvDXiEBLeTVByuXKrGkVU8jnUe2WCvN/+ze0aP2Y8JHXKalmBqeUf3s4Y9IG",
  render_errors: [view: NevernoteWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Nevernote.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
