# frozen_string_literal: true

module OpenAI
  module Core
    class InputDecorator < OpenAI::Core::SimpleDecorator
      delegate_all

      def parameters
        slice(*context.framework.params.keys)
      end

      def valid?
        # run_validations!
        # errors.any?
        true
      end
    end
  end
end
