# frozen_string_literal: true

require "openai/core/service"
require "openai/core/dispatcher"
require "openai/core/api_response"

module OpenAI
  class GPT < OpenAI::Core::Service
    def chat_completion(parameters:)
      context = OpenAI::Core::Dispatcher.call(
        request: OpenAI::Core::Request.new(key: "gpt.chat_completion.params", input: parameters),
        config: configuration
      )
      raise OpenAI::Core::DispatcherError.new(context.messages) unless context.success?
  
      context.payload
      # OpenAI::GPT::ChatCompletion.call(params: params)
    end

    def completion(parameters:)
      params = OpenAI::Core::Parameters.new(key: "gpt.completion.params", input: parameters)
      raise OpenAI::Core::Parameters::InvalidInputError.new(params.errors) unless params.valid?

      OpenAI::GPT::Completion.call(params: params)
    end
  end
end
