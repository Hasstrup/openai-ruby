# frozen_string_literal: true

require "openai/core/simple_decorator"
require "openai/core/request_validator"
require "forwardable"

module OpenAI
  module Core
    class InputDecorator < OpenAI::Core::SimpleDecorator
      extend Forwardable

      delegate_all

      def body
        @body ||= slice(*params.keys.map(&:to_sym))
      end

      def valid?
        errors.none?
      end

      def params
        @params ||= context.framework.params
      end

      def errors
        OpenAI::Core::RequestValidator.call(request: self)
      end
    end
  end
end
