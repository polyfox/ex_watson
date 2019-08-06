defmodule ExWatson.V1.Messages do
  alias HTTPoison.Response
  alias ExWatson.HTTP.Client, as: HTTP
  alias ExWatson.V1.Message

  @type options :: [
    {:workspace_id, String.t()} |
    {:nodes_visited_details, boolean}
  ] | HTTP.options()

  @type message :: %{}

  @spec send_message(message, options) :: {:ok, Message.t()} | {:error, {:invalid_request, term}}
  def send_message(message, options) do
    query_params = []

    query_params =
      if options[:nodes_visited_details] do
        [{"nodes_visited_details", options[:nodes_visited_details]} | query_params]
      else
        query_params
      end

    case HTTP.post("/workspaces/#{options[:workspace_id]}/message", query_params, [], message, options) do
      {:ok, %Response{status_code: 200}, data} ->
        {:ok, Message.from_map(data)}

      {:ok, %Response{status_code: 400}, data} ->
        {:error, {:invalid_request, data}}
    end
  end
end
