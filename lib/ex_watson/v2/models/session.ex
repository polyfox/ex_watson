defmodule ExWatson.V2.Session do
  defstruct [
    :session_id
  ]

  @type t :: %__MODULE__{
    session_id: String.t()
  }
end
