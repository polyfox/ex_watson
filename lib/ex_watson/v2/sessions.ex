defmodule ExWatson.V2.Sessions do
  @moduledoc """
  The sessions API

  See https://cloud.ibm.com/apidocs/assistant-v2#create-a-session
  """
  alias HTTPoison.Response
  alias ExWatson.HTTP.Client, as: HTTP
  alias ExWatson.V2.Session

  @type create_options :: [
    {:assistant_id, String.t()}
  ] | HTTP.options()

  @type delete_options :: [
    {:assistant_id, String.t()} |
    {:session_id, String.t()}
  ] | HTTP.options()

  @spec create_session(create_options) ::
          {:ok, ExWatson.V2.Session.t()} | {:ok, {:invalid_request, term} | term}
  def create_session(options) do
    case HTTP.post("/v2/assistants/#{options[:assistant_id]}/sessions", [], [], nil, options) do
      {:ok, %Response{status_code: 201}, data} ->
        {:ok, Session.from_map(data)}

      {:ok, %Response{status_code: 400}, data} ->
        {:error, {:invalid_request, data}}

      {:error, _} = err ->
        err
    end
  end

  @spec delete_session(delete_options) :: :ok | {:error, {:invalid_request, term} | term}
  def delete_session(options) do
    case HTTP.delete("/v2/assistants/#{options[:assistant_id]}/sessions/#{options[:session_id]}", [], [], options) do
      {:ok, %Response{status_code: 200}, _data} ->
        :ok

      {:ok, %Response{status_code: 400}, data} ->
        {:error, {:invalid_request, data}}

      {:error, _} = err ->
        err
    end
  end
end
