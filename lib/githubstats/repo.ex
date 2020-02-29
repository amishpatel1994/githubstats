defmodule Githubstats.Repo do
  use Ecto.Repo,
    otp_app: :githubstats,
    adapter: Ecto.Adapters.Postgres
end
