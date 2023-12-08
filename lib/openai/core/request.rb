# frozen_string_literal: true

require "openai/core/input_decorator"
require "openai/core/params_parser"
module OpenAI
  module Core
    class Request
      def initialize(key:, input:)
        @key = key
        @input = OpenAI::Core::InputDecorator.decorate(input, context: { framework: framework })
      end

      delegate(*%i[path method response_keys params], to: :framework)
      delegate(*%i[body errors valid?], to: :input)

      private

      attr_reader :input

      def framework
        @framework ||=
          Struct.new(*parser.list(key), keyword_init: true).new(
            **parser.fetch(key),
          )
      end

      def parser
        @parser ||= OpenAI::Core::ParamsParser.new
      end
    end
  end
end
