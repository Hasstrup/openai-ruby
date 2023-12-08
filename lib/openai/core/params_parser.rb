# frozen_string_literal: true

# frozen_string_litera: true

module OpenAI
  module Core
    class ParamsParser
      def list(key)
        params = YAML.load_file("./parameters.yml")
        params.fetch(*key.split(".")).keys
      end

      def fetch(key)
        params = YAML.load_file("./parameters.yml")
        params.fetch(*key.split("."))
      end
    end
  end
end
