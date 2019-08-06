defmodule ExWatson.V1.Messages do
  @type options :: [
    {:workspace_id, String.t()},
    {:version, String.t()},
    {:nodes_visited_details, boolean}
  ]

  @spec send_message(options) :: ExWatson.V1.Message.t()
  def send_message(options) do
    ExWatson.post("/workspaces/#{options[:workspace_id]}/message")
  end
end
