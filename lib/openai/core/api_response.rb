# frozen_string_literal: true

module OpenAI
  module Core
    class ApiResponse < SimpleDecorator
      delegate_all
    end
  end
end
