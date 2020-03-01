defmodule GithubstatsWeb.PageController do
  use GithubstatsWeb, :controller

  def index(conn, params) do
    render(conn, "index.html")
  end

  def update(conn, %{"github" => %{"username" => username}}) do
  	require IEx; IEx.pry
  	render(conn, "index.html")
  end
end
