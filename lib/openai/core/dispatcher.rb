# frozen_string_literal: true

require "openai/core/api_response"
require "openai/core/context"
require "openai/core/response_wrapper"

module OpenAI
  module Core
    class Dispatcher
      class InvalidInputError < StandardError; end
      DEFAULT_OPENAI_API_ROOT = "https://api.openai.com"

      def self.call(**kwargs)
        new(**kwargs).call
      end

      def initialize(request:, config:)
        @config = config
        @request = request
      end

      def call
        return context.fail!(error: InvalidInputError.new(request.errors)) unless request.valid?

        context.succeed(OpenAI::Core::ResponseWrapper.call(
          request: request,
          response: HTTParty.send(request.method, with_openai_root(request.path), request.body),
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
