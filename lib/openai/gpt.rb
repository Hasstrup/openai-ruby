# frozen_string_literal: true

require "openai/core/service"
require "openai/core/request"
require "openai/core/dispatcher"

module OpenAI
  class GPT < OpenAI::Core::Service

    # example: OpenAI::GPT.new.legacy_completion(parameters: { model: "gpt-3.5-turbo-instruct", prompt: "Tell me a good story about the future of the internet"})
    def legacy_completion(parameters:)
      context = OpenAI::Core::Dispatcher.call(
        request: OpenAI::Core::Request.new(key: "gpt.completions.create", input: parameters),
        config: configuration,
      )
      raise OpenAI::Core::Service::DispatchError, context.messages unless context.success?

      context.payload
    end

    # def completion(parameters:)
    #   params = OpenAI::Core::Parameters.new(key: "gpt.completion.params", input: parameters)
    #   raise OpenAI::Core::Parameters::InvalidInputError, params.errors unless params.valid?

    #   OpenAI::GPT::Completion.call(params: params)
    # end
  end
end
