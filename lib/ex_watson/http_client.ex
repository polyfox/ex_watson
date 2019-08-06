defmodule ExWatson.HTTP.Client do
  @moduledoc """
  Intermediate module for handle HTTP requests to IBM Watson
  """
  def request(method, url, query_params, headers, body, options) do

  end

  def get(url, query_params, headers, options) do
    query_params = prepare_query_params(query_params, options)
    headers = prepare_headers(headers, options)
  end

  def post(url, query_params, headers, body, options) do
  end

  def delete(url, query_params, headers, options) do
  end

  defp prepapre_query_params(query_params, options) when is_list(query_params) do
    [{"version", options[:version]} | query_params]
  end

  defp prepapre_query_params(query_params, options) when is_map(query_params) do
    prepapre_query_params(Map.to_list(query_params), options)
  end

  defp prepare_headers(headers, options) do
    headers = Enum.into(headers, %{})

    headers =
      if options[:api_key] do
        Map.put(headers, "authorization", "Bearer #{options[:api_key]}")
      else
        headers
      end

    headers =
      if options[:basic_auth] do
        {username, password} = options[:basic_auth]
        basic_auth = Base.encode64("#{username}:#{password}")
        Map.put(headers, "authorization", "Basic #{basic_auth}")
      else
        headers
      end

    headers
  end
end
