# frozen_string_literal: true

require "openai/core/api_response"
require "openai/core/context"

module OpenAI
  module Core
    class Dispatcher
      DEFAULT_OPENAI_API_ROOT = "" # TODO: fill this up with

      def self.call(**kwargs)
        new(**kwargs).call
      end

      def initialize(request:, config:)
        @config = config
        @request = request
      end

      def call
        return context.fail!(error: OpenAI::Core::Parameters::InvalidInputError.new(request.errors)) unless request.valid?

        # TODO: response wrapper
        context.succeed(OpenAI::Core::ResponseWrapper.wrap(
          request: request,
          response: HTTParty.send(request.method, with_openai_root(request.path), request.parameters),
        ))
      rescue StandardError => e
        context.fail!(error: e)
      end

      private

      attr_reader :config, :request

      def context
        @context ||= OpenAI::Core::Context.new
      end

      def with_openai_root(path)
        ENV.fetch("OPENAI_API_ROOT", DEFAULT_OPENAI_API_ROOT) + path
      end
    end
  end
end
