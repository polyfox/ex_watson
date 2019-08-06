defmodule ExWatson.V1.MessageInput do
  defstruct [
    :text
  ]

  @type t :: %__MODULE__{
    text: String.t()
  }

  def from_map(data) when is_map(data) do
    %__MODULE__{
      text: data["text"]
    }
  end
end

defmodule ExWatson.V1.RuntimeIntent do
  defstruct [
    :intent,
    :confidence,
  ]

  @type t :: %__MODULE__{
    intent: String.t(),
    confidence: float
  }

  def from_map(data) when is_map(data) do
    %__MODULE__{
      intent: data["intent"],
      confidence: data["confidence"]
    }
  end
end

defmodule ExWatson.V1.CaptureGroup do
  defstruct [
    :group,
    :location
  ]

  @type t :: %__MODULE__{
    group: String.t(),
    location: [integer]
  }

  def from_map(data) when is_map(data) do
    %__MODULE__{
      group: data["group"],
      location: data["location"]
    }
  end
end

defmodule ExWatson.V1.RuntimeEntity do
  alias ExWatson.V1.CaptureGroup

  defstruct [
    :entity,
    :location,
    :value,
    :confidence,
    :metadata,
    :groups
  ]

  @type t :: %__MODULE__{
    entity: String.t(),
    location: [integer],
    value: String.t(),
    confidence: number,
    metadata: map,
    groups: [CaptureGroup.t()],
  }

  def from_map(data) when is_map(data) do
    %__MODULE__{
      entity: data["entity"],
      location: data["location"],
      value: data["value"],
      confidence: data["confidence"],
      metadata: data["metadata"],
      groups: Enum.map(data["groups"], &CaptureGroup.from_map/1)
    }
  end
end

defmodule ExWatson.V1.MessageContextMetadata do
  defstruct [
    :deployment,
    :user_id
  ]

  @type t :: %__MODULE__{
    deployment: String.t(),
    user_id: String.t()
  }

  def from_map(data) when is_map(data) do
    %__MODULE__{
      deployment: data["deployment"],
      user_id: data["user_id"]
    }
  end
end

defmodule ExWatson.V1.Context do
  alias ExWatson.V1.MessageContextMetadata

  defstruct [
    :conversation_id,
    :system,
    :metadata
  ]

  @type t :: %__MODULE__{
    conversation_id: String.t(),
    system: map,
    metadata: MessageContextMetadata.t(),
  }

  def from_map(data) when is_map(data) do
    %__MODULE__{
      conversation_id: data["conversation_id"],
      system: data["system"],
      metadata: MessageContextMetadata.from_map(data["metadata"])
    }
  end
end

defmodule ExWatson.V1.LogMessage do
  defstruct [
    :level,
    :msg
  ]

  @type t :: %__MODULE__{
    level: String.t(),
    msg: String.t()
  }

  def from_map(data) when is_map(data) do
    %__MODULE__{
      level: data["level"],
      msg: data["msg"]
    }
  end
end

defmodule ExWatson.V1.DialogNodeOutputOptionsElementValue do
  alias ExWatson.V1.{MessageInput, RuntimeIntent, RuntimeEntity}

  defstruct [
    :input,
    :intents,
    :entities
  ]

  @type t :: %__MODULE__{
    input: MessageInput.t(),
    intents: [RuntimeIntent.t()],
    entities: [RuntimeEntity.t()]
  }

  def from_map(data) when is_map(data) do
    %__MODULE__{
      input: MessageInput.from_map(data["input"]),
      intents: Enum.map(data["intents"], &RuntimeIntent.from_map/1),
      entities: Enum.map(data["entities"], &RuntimeEntity.from_map/1)
    }
  end
end

defmodule ExWatson.V1.DialogNodeOutputOptionsElement do
  alias ExWatson.V1.DialogNodeOutputOptionsElementValue

  defstruct [
    :label,
    :value
  ]

  @type t :: %__MODULE__{
    label: String.t(),
    value: DialogNodeOutputOptionsElementValue.t()
  }

  def from_map(data) when is_map(data) do
    %__MODULE__{
      label: data["label"],
      value: DialogNodeOutputOptionsElementValue.from_map(data["value"])
    }
  end
end

defmodule ExWatson.V1.DialogSuggestionValue do
  alias ExWatson.V1.{MessageInput, RuntimeIntent, RuntimeEntity}

  defstruct [
    :input,
    :intents,
    :entities
  ]

  @type t :: %__MODULE__{
    input: MessageInput.t(),
    intents: [RuntimeIntent.t()],
    entities: [RuntimeEntity.t()]
  }

  def from_map(data) when is_map(data) do
    %__MODULE__{
      input: MessageInput.from_map(data["input"]),
      intents: Enum.map(data["intents"], &RuntimeIntent.from_map/1),
      entities: Enum.map(data["entities"], &RuntimeEntity.from_map/1)
    }
  end
end

defmodule ExWatson.V1.DialogSuggestion do
  alias ExWatson.V1.DialogSuggestionValue

  defstruct [
    :label,
    :value,
    :output,
    :dialog_node
  ]

  @type t :: %__MODULE__{
    label: String.t(),
    value: DialogSuggestionValue.t(),
    output: map,
    dialog_node: String.t()
  }

  def from_map(data) when is_map(data) do
    %__MODULE__{
      label: data["label"],
      value: DialogSuggestionValue.from_map(data["value"]),
      output: data["output"],
      dialog_node: data["dialog_node"],
    }
  end
end

defmodule ExWatson.V1.DialogRuntimeResponseGeneric do
  alias ExWatson.V1.{DialogNodeOutputOptionsElement, DialogSuggestion}

  defstruct [
    :response_type,
    :text,
    :time,
    :typing,
    :source,
    :title,
    :description,
    :preference,
    :options,
    :message_to_human_agent,
    :topic,
    :dialog_node,
    :suggestions
  ]

  @type t :: %__MODULE__{
    response_type: String.t(),
    text: String.t(),
    time: integer,
    typing: boolean,
    source: String.t(),
    title: String.t(),
    description: String.t(),
    preference: String.t(),
    options: [DialogNodeOutputOptionsElement.t()],
    message_to_human_agent: String.t(),
    topic: String.t(),
    dialog_node: String.t(),
    suggestions: [DialogSuggestion.t()],
  }

  def from_map(data) when is_map(data) do
    %__MODULE__{
      response_type: data["response_type"],
      text: data["text"],
      time: data["time"],
      typing: data["typing"],
      source: data["source"],
      title: data["title"],
      description: data["description"],
      preference: data["preference"],
      options: Enum.map(data["options"], &DialogNodeOutputOptionsElement.from_map/1),
      message_to_human_agent: data["message_to_human_agent"],
      topic: data["topic"],
      dialog_node: data["dialog_node"],
      suggestions: Enum.map(data["suggestions"], &DialogSuggestion.from_map/1),
    }
  end
end

defmodule ExWatson.V1.OutputData do
  alias ExWatson.V1.{LogMessage, DialogRuntimeResponseGeneric}
  defstruct [
    :log_messages,
    :text,
    :generic,
    :nodes_visited,
    :nodes_visited_details
  ]

  @type t :: %__MODULE__{
    log_messages: [LogMessage.t()],
    text: [String.t()],
    generic: [DialogRuntimeResponseGeneric.t()],
    nodes_visited: [String.t()],
    nodes_visited_details: [%{
      dialog_node: String.t(),
      title: String.t(),
      conditions: String.t()
    }]
  }

  def from_map(data) when is_map(data) do
    %__MODULE__{
      log_messages: Enum.map(data["log_messages"], &LogMessage.from_map/1),
      text: data["text"],
      generic: Enum.map(data["generic"], &DialogRuntimeResponseGeneric.from_map/1),
      nodes_visited: data["nodes_visited"],
      nodes_visited_details: Enum.map(data["nodes_visited_details"], fn data ->
        %{
          dialog_node: data["dialog_node"],
          title: data["title"],
          conditions: data["conditions"]
        }
      end)
    }
  end
end

defmodule ExWatson.V1.DialogNodeAction do
  defstruct [
    :name,
    :result_variable,
    :type,
    :parameters,
    :credentials
  ]

  @type t :: %__MODULE__{
    name: String.t(),
    result_variable: String.t(),
    type: String.t(),
    parameters: map,
    credentials: String.t(),
  }

  def from_map(data) when is_map(data) do
    %__MODULE__{
      name: data["name"],
      result_variable: data["result_variable"],
      type: data["type"],
      parameters: data["parameters"],
      credentials: data["credentials"]
    }
  end
end

defmodule ExWatson.V1.Message do
  alias ExWatson.V1.{MessageInput, RuntimeIntent, RuntimeEntity, Context, OutputData, DialogNodeAction}

  defstruct [
    :input,
    :intents,
    :entities,
    :context,
    :output,
    :alternate_intents,
    :actions
  ]

  @type t :: %__MODULE__{
    input: MessageInput.t(),
    intents: [RuntimeIntent.t()],
    entities: [RuntimeEntity.t()],
    context: Context.t(),
    output: OutputData.t(),
    alternate_intents: boolean,
    actions: [DialogNodeAction.t()]
  }

  def from_map(data) do
    %__MODULE__{
      input: MessageInput.from_map(data["input"]),
      intents: Enum.map(data["intents"], &RuntimeIntent.from_map/1),
      entities: Enum.map(data["entities"], &RuntimeEntity.from_map/1),
      context: Context.from_map(data["context"]),
      output: OutputData.from_map(data["output"]),
      alternate_intents: data["alternate_intents"],
      actions: Enum.map(data["actions"], &DialogNodeAction.from_map/1)
    }
  end
end
