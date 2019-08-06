defmodule ExWatson.V2.Messages do
  @type message :: map
  @type options :: [
    {:assistant_id, String.t()},
    {:session_id, String.t()},
    {:version, String.t()}
  ]

  @spec send_message(message, options) :: :ok
  def send_message(message, options) do

  end
end
