# frozen_string_literal: true

module OpenAI
  module Core
    class RequestValidator
      attr_reader :errors

      PARAMS_REQUIRED_KEY = "required"
      PARAMS_TYPE_KEY = "type"

      def self.call(**kwargs)
        new(**kwargs).call
      end

      def initialize(request:)
        @request = request
        @errors = {}
      end

      def call
        request.params.keys.each do |key|
          validate_presence(key, request.body.dig(key)) if request.framework.params.dig(key, PARAMS_REQUIRED_KEY)
          validate_type(key, request.framework.params.dig(key, PARAMS_TYPE_KEY), request.body.dig(key))
        end
      end

      private

      attr_reader :request

      def validate_presence(key, value)
        return push_error(key, "#{key} is missing") unless value.present?
      end

      def validate_type(key, type, value)
        return push_error(
          key,
          "#{key} should be a '#{type}' but is a: #{self.class}",
        ) unless type.split(",").include?(value.class)
      end

      def push_error(key, message)
        errors[key] = (errors[key] || []).push(message)
      end
    end
  end
end
