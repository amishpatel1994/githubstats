defmodule Githubstats.Github.HTTPClient do
  @moduledoc """
  This module is an implementation of the 'Githubstats.Github.Client behaviour.'
  """
  require Logger

  @behaviour Githubstats.Github.Client

  @get_num_watches """
    query getNumWatches{
      user(login: "USERNAME"){
        watching{
          totalCount
        }
      }
    }
  """

  @get_watched_repos ~s"""
    query getWatches { 
      user(login: "USERNAME"){
        avatarUrl
        watching(last: NUM_WATCHES) {
          totalCount
          totalDiskUsage
          nodes {
            owner{
              login
            }
            createdAt
            name
            url
            description
            descriptionHTML
            forkCount
            primaryLanguage {
              name
            }
            
          }
        }
      }
    }
  """

  def get_num_watches(username) do
    query = @get_num_watches |> String.replace("USERNAME", username)

    case post(%{query: query}) do
      %{status_code: 200, body: body} ->
        case Poison.decode!(body) do
          %{"data" => %{"user" => %{"watching" => %{"totalCount" => count}}}} ->
            {:ok, count}

          %{"errors" => errors} ->
            Logger.error(
              "#{__MODULE__}.get_num_watches.error " <>
                "body=#{inspect(errors)}"
            )

            {:error, errors}
        end

      %{status_code: status_code, body: body} ->
        Logger.error(
          "#{__MODULE__}.get_num_watches.error " <>
            "status=#{status_code} body=#{inspect(body)}}"
        )

        {:error, Poison.decode!(body)}
    end
  end

  def get_watched_repos(username, num_watches) do
    query =
      @get_watched_repos
      |> String.replace("USERNAME", username)
      |> String.replace("NUM_WATCHES", to_string(num_watches))

    case post(%{query: query}) do
      %{status_code: 200, body: body} ->
        case Poison.decode!(body) do
          %{
            "data" => %{
              "user" => %{"avatarUrl" => image_url, "watching" => %{"nodes" => watches}}
            }
          } ->
            {:ok, %{"watches" => watches, "image_url" => image_url}}

          %{"errors" => errors} ->
            Logger.error(
              "#{__MODULE__}.get_watched_repos.error " <>
                "body=#{inspect(errors)}"
            )

            {:error, errors}
        end

      %{status_code: status_code, body: body} ->
        Logger.error(
          "#{__MODULE__}.get_watched_repos.error " <>
            "status=#{status_code} body=#{inspect(body)}}"
        )

        {:error, Poison.decode!(body)}
    end
  end

  defp post(body) do
    headers = [
      {"Content-Type", "application/json"},
      {"Authorization", "Bearer #{api_key()}"}
    ]

    url()
    |> HTTPoison.post!(
      Poison.encode!(body),
      headers
    )
  end

  defp api_key do
    config()[:api_key]
  end

  defp url do
    config()[:url]
  end

  defp config do
    Application.get_env(:githubstats, :github)
  end
end
