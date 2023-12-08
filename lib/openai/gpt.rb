# frozen_string_literal: true

require "openai/core/service"
require "openai/core/dispatcher"
require "openai/core/api_response"

module OpenAI
  class GPT < OpenAI::Core::Service
    def chat_completion(parameters:)
      context = OpenAI::Core::Dispatcher.call(
        request: OpenAI::Core::Request.new(key: "gpt.completions.create.params", input: parameters),
        config: configuration,
      )
      raise OpenAI::Core::DispatcherError, context.messages unless context.success?

      context.payload
    end

    def completion(parameters:)
      params = OpenAI::Core::Parameters.new(key: "gpt.completion.params", input: parameters)
      raise OpenAI::Core::Parameters::InvalidInputError, params.errors unless params.valid?

      OpenAI::GPT::Completion.call(params: params)
    end
  end
end
