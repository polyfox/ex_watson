defmodule ExWatson.V2.Generic do
  defstruct [

  ]

  @type t :: %__MODULE__{

  }

  def from_map(nil), do: nil

  def from_map(data) when is_map(data) do
    %__MODULE__{

    }
  end
end

defmodule ExWatson.V2.MessageInputOptions do
  defstruct [
    :debug,
    :restart,
    :alternate_inputs,
    :return_context
  ]

  @type t :: %__MODULE__{
    debug: boolean,
    restart: boolean,
    alternate_inputs: boolean,
    return_context: boolean
  }

  def from_map(nil), do: nil

  def from_map(data) when is_map(data) do
    %__MODULE__{
      debug: data["debug"],
      restart: data["restart"],
      alternate_inputs: data["alternate_inputs"],
      return_context: data["return_context"]
    }
  end
end

defmodule ExWatson.V2.MessageInput do
  alias ExWatson.V2.{MessageInputOptions,
                     RuntimeIntent,
                     RuntimeEntity}

  import ExWatson.Util.Collections

  defstruct [
    :message_type,
    :text,
    :options,
    :intents,
    :entities,
    :suggestion_id,
  ]

  @type t :: %__MODULE__{
    message_type: String.t(),
    text: String.t(),
    options: MessageInputOptions.t(),
    intents: [RuntimeIntent.t()],
    entities: [RuntimeEntity.t()],
    suggestion_id: String.t(),
  }

  def from_map(nil), do: nil

  def from_map(data) when is_map(data) do
    %__MODULE__{
      message_type: data["message_type"],
      text: data["text"],
      options: MessageInputOptions.from_map(data["options"]),
      intents: maybe_map(data["intents"], &RuntimeIntent.from_map/1),
      entities: maybe_map(data["entities"], &RuntimeEntity.from_map/1),
      suggestion_id: data["suggestion_id"]
    }
  end
end

defmodule ExWatson.V2.DialogNodeOutputOptionsElementValue do
  alias ExWatson.V2.MessageInput

  defstruct [
    :input
  ]

  @type t :: %__MODULE__{
    input: MessageInput.t()
  }

  def from_map(nil), do: nil

  def from_map(data) when is_map(data) do
    %__MODULE__{
      input: MessageInput.from_map(data["input"]),
    }
  end
end

defmodule ExWatson.V2.DialogNodeOutputOptionsElement do
  alias ExWatson.V2.DialogNodeOutputOptionsElementValue

  defstruct [
    :label,
    :value
  ]

  @type t :: %__MODULE__{
    label: String.t(),
    value: DialogNodeOutputOptionsElementValue.t()
  }

  def from_map(nil), do: nil

  def from_map(data) when is_map(data) do
    %__MODULE__{
      label: data["label"],
      value: DialogNodeOutputOptionsElementValue.from_map(data["value"]),
    }
  end
end

defmodule ExWatson.V2.DialogSuggestionValue do
  alias ExWatson.V2.MessageInput

  defstruct [
    :input
  ]

  @type t :: %__MODULE__{
    input: MessageInput.t()
  }

  def from_map(nil), do: nil

  def from_map(data) when is_map(data) do
    %__MODULE__{
      input: MessageInput.from_map(data["input"]),
    }
  end
end

defmodule ExWatson.V2.DialogSuggestion do
  alias ExWatson.V2.DialogSuggestionValue

  defstruct [
    :label,
    :value,
    :output
  ]

  @type t :: %__MODULE__{
    label: String.t(),
    value: DialogSuggestionValue.t(),
    output: map
  }

  def from_map(nil), do: nil

  def from_map(data) when is_map(data) do
    %__MODULE__{
      label: data["label"],
      value: DialogSuggestionValue.from_map(data["value"]),
      output: data["output"],
    }
  end
end

defmodule ExWatson.V2.SearchResultMetadata do
  defstruct [
    :confidence,
    :score
  ]

  @type t :: %__MODULE__{
    confidence: float,
    score: float,
  }

  def from_map(nil), do: nil

  def from_map(data) when is_map(data) do
    %__MODULE__{
      confidence: data["confidence"],
      score: data["score"]
    }
  end
end

defmodule ExWatson.V2.SearchResultHighlight do
  defstruct [
    :body,
    :title,
    :url,
    :other
  ]

  @type t :: %__MODULE__{
    body: [String.t()],
    title: [String.t()],
    url: [String.t()],
    other: [String.t()]
  }

  def from_map(nil), do: nil

  def from_map(data) when is_map(data) do
    %__MODULE__{
      body: data["body"],
      title: data["title"],
      url: data["url"],
      # The docs aren't exactly clear about this field
      # if it's not working correctly for you, let me know
      other: data["other"]
    }
  end
end

defmodule ExWatson.V2.SearchResult do
  alias ExWatson.V2.{SearchResultMetadata, SearchResultHighlight}

  defstruct [
    :id,
    :result_metadata,
    :body,
    :title,
    :url,
    :highlight
  ]

  @type t :: %__MODULE__{
    id: String.t(),
    result_metadata: SearchResultMetadata.t(),
    body: String.t(),
    title: String.t(),
    url: String.t(),
    highlight: SearchResultHighlight.t(),
  }

  def from_map(nil), do: nil

  def from_map(data) when is_map(data) do
    %__MODULE__{
      id: data["id"],
      result_metadata: SearchResultMetadata.from_map(data["result_metadata"]),
      body: data["body"],
      title: data["title"],
      url: data["url"],
      highlight: SearchResultHighlight.from_map(data["highlight"])
    }
  end
end

defmodule ExWatson.V2.DialogRuntimeResponseGeneric do
  alias ExWatson.V2.{DialogNodeOutputOptionsElement, DialogSuggestion, SearchResult}

  import ExWatson.Util.Collections

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
    :suggestions,
    :header,
    :results
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
    suggestions: [DialogSuggestion.t()],
    header: String.t(),
    results: [SearchResult.t()]
  }

  def from_map(nil), do: nil

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
      options: maybe_map(data["options"], &DialogNodeOutputOptionsElement.from_map/1),
      message_to_human_agent: data["message_to_human_agent"],
      topic: data["topic"],
      suggestions: maybe_map(data["suggestions"], &DialogSuggestion.from_map/1),
      header: data["header"],
      results: maybe_map(data["results"], &SearchResult.from_map/1)
    }
  end
end

defmodule ExWatson.V2.RuntimeIntent do
  defstruct [
    :intent,
    :confidence
  ]

  @type t :: %__MODULE__{
    intent: String.t(),
    confidence: float,
  }

  def from_map(nil), do: nil

  def from_map(data) when is_map(data) do
    %__MODULE__{
      intent: data["intent"],
      confidence: data["confidence"]
    }
  end
end

defmodule ExWatson.V2.RuntimeEntityRole do
  defstruct [
    :type
  ]

  @type t :: %__MODULE__{
    type: String.t()
  }

  def from_map(nil), do: nil

  def from_map(data) when is_map(data) do
    %__MODULE__{
      type: data["type"]
    }
  end
end

defmodule ExWatson.V2.RuntimeEntityAlternative do
  defstruct [
    :value,
    :confidence
  ]

  @type t :: %__MODULE__{
    value: String.t(),
    confidence: number
  }

  def from_map(nil), do: nil

  def from_map(data) when is_map(data) do
    %__MODULE__{
      value: data["value"],
      confidence: data["confidence"]
    }
  end
end

defmodule ExWatson.V2.RuntimeEntity do
  alias ExWatson.V2.{RuntimeEntityRole, RuntimeEntityAlternative}

  import ExWatson.Util.Collections

  defstruct [
    :entity,
    :location,
    :value,
    :confidence,
    :metadata,
    :groups,
    :interpretation,
    :alternatives,
    :role,
  ]

  @type interpretation :: %{
    calendar_type: String.t(),
    datetime_link: String.t(),
    festival: String.t(),
    granularity: String.t(),
    range_link: String.t(),
    range_modifier: String.t(),
    relative_day: number,
    relative_month: number,
    relative_week: number,
    relative_weekend: number,
    relative_year: number,
    specific_day: number,
    specific_day_of_week: String.t(),
    specific_month: number,
    specific_quarter: number,
    specific_year: number,
    numeric_value: number,
    subtype: String.t(),
    part_of_day: String.t(),
    relative_hour: number,
    relative_minute: number,
    relative_second: number,
    specific_hour: number,
    specific_minute: number,
    specific_second: number,
    timezone: String.t()
  }

  @type t :: %__MODULE__{
    entity: String.t(),
    location: [integer],
    value: String.t(),
    confidence: number,
    metadata: map,
    groups: [%{
      group: String.t(),
      location: [integer]
    }],
    interpretation: interpretation,
    alternatives: String.t(),
    role: String.t(),
  }

  def from_map(nil), do: nil

  def from_map(data) when is_map(data) do
    %__MODULE__{
      entity: data["entity"],
      location: data["location"],
      value: data["value"],
      confidence: data["confidence"],
      metadata: data["metadata"],
      groups: maybe_map(data["groups"], &(%{group: &1["group"], location: &1["location"]})),
      interpretation: interpretation_from_map(data["interpretation"]),
      alternatives: maybe_map(data["alternatives"], &RuntimeEntityAlternative.from_map/1),
      role: RuntimeEntityRole.from_map(data["role"]),
    }
  end

  def interpretation_from_map(data) do
    %{
      calendar_type: data["calendar_type"],
      datetime_link: data["datetime_link"],
      festival: data["festival"],
      granularity: data["granularity"],
      range_link: data["range_link"],
      range_modifier: data["range_modifier"],
      relative_day: data["relative_day"],
      relative_month: data["relative_month"],
      relative_week: data["relative_week"],
      relative_weekend: data["relative_weekend"],
      relative_year: data["relative_year"],
      specific_day: data["specific_day"],
      specific_day_of_week: data["specific_day_of_week"],
      specific_month: data["specific_month"],
      specific_quarter: data["specific_quarter"],
      specific_year: data["specific_year"],
      numeric_value: data["numeric_value"],
      subtype: data["subtype"],
      part_of_day: data["part_of_day"],
      relative_hour: data["relative_hour"],
      relative_minute: data["relative_minute"],
      relative_second: data["relative_second"],
      specific_hour: data["specific_hour"],
      specific_minute: data["specific_minute"],
      specific_second: data["specific_second"],
      timezone: data["timezone"]
    }
  end
end

defmodule ExWatson.V2.DialogNodeAction do
  defstruct [
    :name,
    :result_variable,
    :type,
    :parameters,
    :credentials,
  ]

  @type t :: %__MODULE__{
    name: String.t(),
    result_variable: String.t(),
    type: String.t(),
    parameters: map,
    credentials: String.t(),
  }

  def from_map(nil), do: nil

  def from_map(data) when is_map(data) do
    %__MODULE__{
      name: data["name"],
      result_variable: data["result_variable"],
      type: data["type"],
      parameters: data["parameters"],
      credentials: data["credentials"],
    }
  end
end

defmodule ExWatson.V2.MessageOutputDebug do
  defstruct [
    :nodes_visited,
    :log_messages,
    :branch_exited,
    :branch_exited_reason
  ]

  @type t :: %__MODULE__{
    nodes_visited: [map],
    log_messages: [DialogLogMessage.t()],
    branch_exited: boolean,
    branch_exited_reason: String.t(),
  }

  def from_map(nil), do: nil

  def from_map(data) when is_map(data) do
    %__MODULE__{
      nodes_visited: data["nodes_visited"],
      log_messages: data["log_messages"],
      branch_exited: data["branch_exited"],
      branch_exited_reason: data["branch_exited_reason"]
    }
  end
end

defmodule ExWatson.V2.MessageOutput do
  alias ExWatson.V2.{DialogRuntimeResponseGeneric,
                     MessageOutputDebug,
                     RuntimeIntent,
                     RuntimeEntity,
                     DialogNodeAction}

  import ExWatson.Util.Collections

  defstruct [
    :generic,
    :intents,
    :entities,
    :actions,
    :debug,
    :user_defined,
  ]

  @type t :: %__MODULE__{
    generic: [DialogRuntimeResponseGeneric.t()],
    intents: [RuntimeIntent.t()],
    entities: [RuntimeEntity.t()],
    actions: [DialogNodeAction.t()],
    debug: MessageOutputDebug.t(),
    user_defined: String.t()
  }

  def from_map(nil), do: nil

  def from_map(data) when is_map(data) do
    %__MODULE__{
      generic: maybe_map(data["generic"], &DialogRuntimeResponseGeneric.from_map/1),
      intents: maybe_map(data["intents"], &RuntimeIntent.from_map/1),
      entities: maybe_map(data["entities"], &RuntimeEntity.from_map/1),
      actions: maybe_map(data["actions"], &DialogNodeAction.from_map/1),
      debug: MessageOutputDebug.from_map(data["debug"]),
      user_defined: data["user_defined"],
    }
  end
end

defmodule ExWatson.V2.MessageContextGlobalSystem do
  defstruct [
    :timezone,
    :user_id,
    :turn_count,
    :locale,
    :reference_time
  ]

  @type t :: %__MODULE__{
    timezone: String.t(),
    user_id: String.t(),
    turn_count: integer,
    locale: String.t(),
    reference_time: String.t()
  }

  def from_map(nil), do: nil

  def from_map(data) when is_map(data) do
    %__MODULE__{
      timezone: data["timezone"],
      user_id: data["user_id"],
      turn_count: data["turn_count"],
      locale: data["locale"],
      reference_time: data["reference_time"],
    }
  end
end

defmodule ExWatson.V2.MessageContextGlobal do
  defstruct [
    :system
  ]

  @type t :: %__MODULE__{
    system: ExWatson.V2.MessageContextGlobalSystem.t(),
  }

  def from_map(nil), do: nil

  def from_map(data) when is_map(data) do
    %__MODULE__{
      system: ExWatson.V2.MessageContextGlobalSystem.from_map(data["system"]),
    }
  end
end

defmodule ExWatson.V2.MessageContextSkill do
  defstruct [
    :user_defined
  ]

  @type t :: %__MODULE__{
    # not too clear, could be an array or something
    user_defined: String.t()
  }

  def from_map(nil), do: nil

  def from_map(data) when is_map(data) do
    %__MODULE__{
      user_defined: data["user_defined"]
    }
  end
end

defmodule ExWatson.V2.MessageContext do
  alias ExWatson.V2.MessageContextSkill

  defstruct [
    :global,
    :skills
  ]

  @type t :: %__MODULE__{
    global: ExWatson.V2.MessageContextGlobal.t(),
    skills: %{String.t() => MessageContextSkill.t()}
  }

  def from_map(nil), do: nil

  def from_map(data) when is_map(data) do
    %__MODULE__{
      global: ExWatson.V2.MessageContextGlobal.from_map(data["global"]),
      skills: Enum.reduce(data["skills"], fn {key, data}, acc ->
        Map.put(acc, key, MessageContextSkill.from_map(data))
      end)
    }
  end
end

defmodule ExWatson.V2.Message do
  defstruct [
    :output,
    :context
  ]

  @type t :: %__MODULE__{
    output: ExWatson.V2.MessageOutput.t(),
    context: ExWatson.V2.MessageContext.t(),
  }

  def from_map(nil), do: nil

  def from_map(data) when is_map(data) do
    %__MODULE__{
      output: ExWatson.V2.MessageOutput.from_map(data["output"]),
      context: ExWatson.V2.MessageContext.from_map(data["context"]),
    }
  end
end
