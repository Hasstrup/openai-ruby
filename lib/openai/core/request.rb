# frozen_string_literal: true

module OpenAI
  module Core
    class Request
      class << self
        # should be called as in Parameters.list("gpt.chat_completion")
        def list(key)
          params = YAML.load_file("./parameters.yml")
          params.fetch(*key.split(".")).keys
        end

        def fetch(key)
          params = YAML.load_file("./parameters.yml")
          params.fetch(*key.split("."))
        end
      end

      def initialize(key:, input:)
        @key = key
        @input = OpenAI::Core::InputDecorator.decorate(input, context: { framework: framework })
      end

      delegate *%i[path method response_keys], to: :framework
      delegate *%i[parameters errors valid?], to: :input

      private

      attr_reader :input

      def framework
        @framework ||=
          Struct.new(*self.class.list(key), keyword_init: true).new(
            **self.class.fetch(key),
          )
      end
    end
  end
end
