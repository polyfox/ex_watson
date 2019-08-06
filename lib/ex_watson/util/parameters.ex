defmodule ExWatson.Util.Parameters do
  @moduledoc """
  Helper module for checking presence of parameters.
  """
  def required_fields(data, fields) do
    Enum.reduce_while(fields, {:ok, data}, fn
      key, {:ok, data} ->
        case data[key] do
          nil ->
            {:halt, {:error, {:missing_field, key}}}

          _ ->
            {:cont, {:ok, data}}
        end
    end)
  end
end
