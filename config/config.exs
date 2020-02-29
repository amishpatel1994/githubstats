# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :githubstats,
  ecto_repos: [Githubstats.Repo]

# Configures the endpoint
config :githubstats, GithubstatsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ONx43owSA0mWl2O9IIhhZAX1A4irkWY8eXe9f0GRaE18gk9bKnIXs+Ab4do+PsVW",
  render_errors: [view: GithubstatsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Githubstats.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "K6siXOov"]

config :githubstats, :github,
  url: System.get_env("GITHUB_URL"),
  api_key: System.get_env("GITHUB_API_KEY")

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
