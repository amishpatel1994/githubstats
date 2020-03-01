defmodule GithubstatsWeb.PageController do
  use GithubstatsWeb, :controller

  alias Githubstats.Github.HTTPClient

  def index(conn, params) do
    render(conn, "index.html", watches: [], count: '')
  end

  def update(conn, %{"github" => %{"username" => username}}) do
    with {:ok, count} <- HTTPClient.get_num_watches(username),
         {:ok, %{"watches" => watches}} <-
           HTTPClient.get_watched_repos(username, count) do
      render(conn, "index.html", watches: watches, count: count)
    else
      {:error, [%{"message" => message}]} ->
        conn
        |> put_flash(:error, message)
        |> render("index.html", watches: [], count: '')

      _ ->
        conn
        |> put_flash(:error, "Something went wrong. Please try again later.")
        |> render("index.html", watches: [], count: '')
    end
  end
end
