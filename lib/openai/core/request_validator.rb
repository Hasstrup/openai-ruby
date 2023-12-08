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
        run_validations!
        @errors
      end

      private

      attr_reader :request

      def run_validations!
        request.params.keys.map(&:to_sym).each do |key|
          validate_presence(key, request.body.dig(key)) if request.params.dig(key.to_s, PARAMS_REQUIRED_KEY)
          validate_type(key, request.params.dig(key.to_s, PARAMS_TYPE_KEY), request.body.dig(key))
        end
      end

      def validate_presence(key, value)
        push_error(key, missing_param_error_message(key)) unless value
      end

      def validate_type(key, type, value)
        push_error(key, invalid_type_error_message(key, type)) if value && !type.split(",").include?(value.class.to_s)
      end

      def push_error(key, message)
        errors[key] = (errors[key] || []).push(message)
      end

      def invalid_type_error_message(key, type)
        "#{key} should be a '#{type}' but is a: #{value.class}"
      end

      def missing_param_error_message(key)
        "#{key} is missing"
      end
    end
  end
end
