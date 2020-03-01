defmodule GithubstatsWeb.PageController do
  use GithubstatsWeb, :controller

  alias Githubstats.Github.HTTPClient

  def index(conn, params) do
    render(conn, "index.html", image_url: '', watches: [], count: '')
  end

  def update(conn, %{"github" => %{"username" => username}}) do
    with {:ok, count} <- HTTPClient.get_num_watches(username),
         {:ok, %{"watches" => watches, "image_url" => image_url}} <-
           HTTPClient.get_watched_repos(username, count) do
      render(conn, "index.html", image_url: image_url, watches: watches, count: count)
    end

    render(conn, "index.html")
  end
end
