defmodule ExWatson.Util.Collections do
  def maybe_map(nil, _callback) do
    nil
  end

  def maybe_map(value, callback) when is_list(value) do
    Enum.map(value, callback)
  end
end
