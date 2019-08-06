defmodule ExWatson.V2.Sessions do
  @moduledoc """
  The sessions API

  See https://cloud.ibm.com/apidocs/assistant-v2#create-a-session
  """
  @type create_options :: [
    {:assistant_id, String.t()},
    {:version, String.t()}
  ]

  @type delete_options :: [
    {:assistant_id, String.t()},
    {:session_id, String.t()},
    {:version, String.t()}
  ]

  @default_version "2019-02-28"

  @spec create_session(create_options) :: ExWatson.V2.Session.t()
  def create_session(options) do
    ExWatson.HTTP.Client.post("/v2/assistants/#{options[:assistant_id]}/sessions")
  end

  @spec create_session(delete_options) :: :ok
  def delete_session(options) do
    ExWatson.HTTP.Client.delete("/v2/assistants/#{options[:assistant_id]}/sessions/#{options[:session_id]}")
  end
end
