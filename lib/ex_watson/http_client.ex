defmodule ExWatson.HTTP.Client do
  @moduledoc """
  Intermediate module for handle HTTP requests to IBM Watson
  """
  alias HTTPoison.Response

  @type options :: [
    {:version, String.t() | nil},
    {:endpoint, String.t() | nil},
    {:api_key, String.t() | nil},
    {:basic_auth, {String.t(), String.t()} | nil}
  ]

  # Yes I am aware that HTTPoison.Base exists, but I need to manipulate various
  # aspects of the request using user supplied options.

  @spec request(atom, String.t(), map | Keyword.t(), map | list, binary | nil, Keyword.t() | map) ::
          HTTPoison.Response.t()
  def request(method, url, query_params, headers, body, options) do
    options = Enum.into(options, %{})
    query_params = prepare_query_params(query_params, options)
    headers = prepare_headers(headers, options)
    url = prepare_url(url, options)

    request_options = [params: query_params]

    case HTTPoison.request(method, url, body, headers, request_options) do
      {:ok, %Response{body: body} = response} ->
        {:ok, response, Jason.decode!(body)}

      {:error, _} = err ->
        err
    end
  end

  def get(url, query_params, headers, options) do
    request(:get, url, query_params, headers, nil, options)
  end

  def post(url, query_params, headers, body, options) do
    request(:post, url, query_params, headers, Jason.encode!(body), options)
  end

  def delete(url, query_params, headers, options) do
    request(:delete, url, query_params, headers, nil, options)
  end

  defp prepare_url(path_url, options) do
    endpoint = options[:endpoint] || Application.get_env(:ex_watson, :default_endpoint)

    endpoint <> path_url
  end

  defp prepare_query_params(query_params, options) when is_list(query_params) do
    version = options[:version] || Application.get_env(:ex_watson, :default_version)
    [{"version", version} | query_params]
  end

  defp prepare_query_params(query_params, options) when is_map(query_params) do
    prepare_query_params(Map.to_list(query_params), options)
  end

  defp prepare_headers(headers, options) do
    headers = Enum.into(headers, %{})

    # normalize headers
    headers =
      Enum.reduce(headers, %{}, fn
        {key, value}, acc when is_binary(key) ->
          Map.put(acc, String.downcase(key), value)

        {key, value}, acc when is_atom(key) ->
          key =
            key
            |> Atom.to_string()
            |> String.downcase()
            |> String.replace("_", "-")

          Map.put(acc, key, value)
      end)

    headers =
      Map.merge(%{
        "accept" => "application/json",
        "content-type" => "application/json",
        "user-agent" => "ex_watson/1.0.0 (Elixir Watson Client)"
      }, headers)

    # add Bearer Authorization if needed
    headers =
      if options[:api_key] do
        Map.put(headers, "authorization", "Bearer #{options[:api_key]}")
      else
        headers
      end

    # add Basic Authorization if needed
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
