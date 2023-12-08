# frozen_string_literal: true

require "openai/core/configuration"

module OpenAI
  module Core
    class Service
      OPENAI_API_KEY = "OPENAI_API_KEY"
      OPENAI_ORGANIZATION_KEY = "OPENAI_ORGANIZATION_ID"

      def initialize(organization: nil, api_key: nil)
        @config = configuration_defaults.merge(organization: organization, api_key: api_key)
      end

      private

      attr_reader :config

      def configuration_defaults
        @configuration_defaults ||= {
          api_key:      ENV[OPENAI_API_KEY],
          organization: ENV[OPENAI_ORGANIZATION_KEY],
        }
      end

      def configuration
        @configuration ||= OpenAI::Core::Configuration.new(**params)
      end
    end
  end
end
