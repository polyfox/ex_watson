defmodule ExWatson.V2.Session do
  defstruct [
    :session_id
  ]

  @type t :: %__MODULE__{
    session_id: String.t()
  }

  def from_map(data) when is_map(data) do
    %__MODULE__{
      session_id: data["session_id"]
    }
  end
end
