# frozen_string_literal: true

module OpenAI
  module Core
    CONFIGURATION_KEYS = %i(organization api_key)
    class Configuration < Struct.new(*CONFIGURATION_KEYS, keyword_init: true)
    end
  end
end
