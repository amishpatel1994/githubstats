defmodule Githubstats.Github.Client do
  @moduledoc """
  This module defines the behavior for Github API.
  """

  @type http_response :: %{
  	status_code: integer,
  	body: term,
  	request_params: keyword
  }

  # TODO: We should replace this with pagination in future
  @callback get_num_watches(String.t()) :: {:ok, integer} | {:error, http_response}

  @callback get_watched_repos(String.t()) :: {:ok, %{}} | {:error, http_response}
end
