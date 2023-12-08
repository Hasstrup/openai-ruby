# frozen_string_literal: true

require "ostruct"

module OpenAI
  module Core
    class ResponseWrapper
      def self.call(**kwargs)
        new(**kwargs).call
      end

      def initialize(request:, response:)
        @request = request
        @response = response
      end

      def call
        payload.none? ? response : payload
      end

      private

      attr_reader :request, :response

      def payload
        @payload ||= response.slice(*request.response_keys)
      end
    end
  end
end
