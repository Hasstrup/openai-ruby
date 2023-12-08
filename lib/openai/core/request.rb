# frozen_string_literal: true

require "openai/core/input_decorator"
require "openai/core/params_parser"
require "forwardable"
require "ostruct"

module OpenAI
  module Core
    class Request
      extend Forwardable

      def initialize(key:, input:)
        @key = key
        @input = OpenAI::Core::InputDecorator.decorate(input, context: { framework: framework })
      end

      def_delegators :@framework, *%i[path method response_keys params]
      def_delegators :@input, *%i[body errors valid?]

      private

      attr_reader :input, :key

      def framework
        @framework ||= OpenStruct.new(**parser.fetch(key))
      end

      def parser
        @parser ||= OpenAI::Core::ParamsParser.new
      end
    end
  end
end
