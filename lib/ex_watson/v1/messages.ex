defmodule ExWatson.V1.Messages do
  alias HTTPoison.Response
  alias ExWatson.HTTP.Client, as: HTTP
  alias ExWatson.V1.Message
  import ExWatson.Util.Parameters

  @type options :: [
    {:workspace_id, String.t()} |
    {:nodes_visited_details, boolean}
  ] | HTTP.options()

  @type message :: %{}

  @spec send_message(message, options) :: {:ok, Message.t()} | {:error, {:invalid_request, term}}
  def send_message(message, options) do
    with {:ok, options} <- required_fields(options, [:workspace_id]),
         query_params <- prepare_query_params([], options),
         {:ok, %Response{status_code: 200}, data} <- HTTP.post(
           "/v1/workspaces/#{options[:workspace_id]}/message",
           query_params, [], message, options) do
      {:ok, Message.from_map(data)}
    end
  end

  defp prepare_query_params(query_params, options) do
    if options[:nodes_visited_details] do
      [{"nodes_visited_details", options[:nodes_visited_details]} | query_params]
    else
      query_params
    end
  end
end
