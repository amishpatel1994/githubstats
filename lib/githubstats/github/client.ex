defmodule Githubstats.Github.Client do
  @moduledoc """
  This module defines the behavior for Github API.
  """

  @type http_response :: %{
  	status_code: integer,
  	body: term,
  	request_params: keyword
  }

  @callback get_watched_repos(String.t()) :: {:ok, _} | {:error, http_response}
end
