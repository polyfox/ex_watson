defmodule ExWatson.V1 do
  alias ExWatson.V1.Workspaces
  alias ExWatson.V1.Messages

  defdelegate send_message(message, options), to: Messages
  defdelegate create_workspace(options), to: Workspaces
end
