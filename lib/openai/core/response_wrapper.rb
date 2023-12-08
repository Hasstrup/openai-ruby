# frozen_string_literal: true

module OpenAI
  module Core
    class ResponseWrapper
      def self.call(**kwargs)
        new(**kwargs).wrap
      end

      def initialize(request:, response:)
        @request = request
        @response = response
      end

      def call
        Struct.new(*request.response_keys, keyword_init: true).new(**
          response.body.slice(*request.response_keys))
      end

      private

      attr_reader :request, :response
    end
  end
end
