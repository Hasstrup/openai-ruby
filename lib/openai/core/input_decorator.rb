# frozen_string_literal: true

require "openai/core/simple_decorator"
require "openai/core/request_validator"

module OpenAI
  module Core
    class InputDecorator < OpenAI::Core::SimpleDecorator
      delegate_all

      def body
        slice(*context.framework.params.keys)
      end

      def valid?
        validation_errors.none?
      end

      delegate :framework, to: :context

      private

      def validation_errors
        @validation_errors ||= OpenAI::Core::RequestValidator.call(request: self)
      end
    end
  end
end
