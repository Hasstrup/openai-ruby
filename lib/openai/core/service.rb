# frozen_string_literal: true

require "openai/core/configuration"

module OpenAI
  module Core
    class Service
      class DispatchError < StandardError; end

      OPENAI_API_KEY = "OPENAI_API_KEY"
      OPENAI_ORGANIZATION_KEY = "OPENAI_ORGANIZATION_ID"

      def initialize(organization: nil, api_key: nil)
        @organization = organization || ENV[OPENAI_ORGANIZATION_KEY]
        @api_key = api_key || ENV[OPENAI_API_KEY]
      end

      private

      attr_reader :config, :organization, :api_key

      def configuration
        @configuration ||= OpenAI::Core::Configuration.new(organization: organization, api_key: api_key)
      end
    end
  end
end
