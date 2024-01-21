# frozen_string_literal: true

# frozen_string_litera: true
require "yaml"

module OpenAI
  module Core
    class ParamsParser
      def list(key)
        fetch(key).keys
      end

      def fetch(key)
        params.dig(*key.split("."))
      end

      private

      def params
        @params ||= YAML.load_file(File.join(File.dirname(__FILE__), "./parameters.yml"))
      end
    end
  end
end
