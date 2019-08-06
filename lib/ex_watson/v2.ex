defmodule ExWatson.V2 do
  alias ExWatson.V2.Sessions
  alias ExWatson.V2.Messages

  defdelegate send_message(message, options), to: Messages
  defdelegate create_session(options), to: Sessions
  defdelegate delete_session(options), to: Sessions
end
