defmodule ExWatson.V2.Messages do
  alias HTTPoison.Response
  alias ExWatson.HTTP.Client, as: HTTP
  alias ExWatson.V2.Message
  import ExWatson.Util.Parameters

  @type message_input_options :: %{
    debug: boolean,
    restart: boolean,
    alternate_intents: boolean,
    return_context: boolean,
  }

  @type runtime_intent :: %{
    intent: String.t(),
    confidence: float,
  }

  @type group :: %{
    group: String.t(),
    location: [integer]
  }

  @type runtime_entity_interpretation :: ExWatson.V2.RuntimeEntity.interpretation()

  @type runtime_entity_alternative :: %{
    value: String.t(),
    confidence: number,
  }

  @type runtime_entity_role :: %{
    type: String.t(),
  }

  @type runtime_entity :: %{
    entity: String.t(),
    location: [integer],
    value: String.t(),
    confidence: number,
    metadata: map,
    groups: [group],
    interpretation: runtime_entity_interpretation,
    alternatives: [runtime_entity_alternative],
    role: runtime_entity_role
  }

  @type input :: %{
    message_type: String.t(),
    text: String.t(),
    options: message_input_options,
    intent: [runtime_intent],
    entities: [runtime_entity],
    suggestion_id: String.t()
  }

  @type message_context_global_system :: %{
    timezone: String.t(),
    user_id: String.t(),
    turn_count: integer,
    locale: String.t(),
    reference_time: String.t()
  }

  @type message_context_global :: %{
    system: message_context_global_system
  }

  @type context :: %{
    global: message_context_global,
    skills: map
  }

  @type message_input :: %{
    input: input,
    context: context
  }

  @type options :: [
    {:assistant_id, String.t()} |
    {:session_id, String.t()}
  ] | HTTP.options()

  @spec send_message(message_input, options) ::
          {:ok, Message.t()} | {:error, {:invalid_request, term} | term}
  def send_message(message, options) do
    with {:ok, options} <- required_fields(options, [:assistant_id, :session_id]),
         {:ok, %Response{status_code: 200}, data} <- HTTP.post(
            "/v2/assistants/#{options[:assistant_id]}/sessions/#{options[:session_id]}/message",
            [], [], message, options) do
      {:ok, Message.from_map(data)}
    end
  end
end
