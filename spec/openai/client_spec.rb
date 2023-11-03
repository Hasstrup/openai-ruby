# frozen_string_literal: true

require "openai/client"
require "spec_helper"

RSpec.describe OpenAI::Client do
  describe "#call" do
    subject { described_class.new.call }

    it { is_expected.to eq("Getting started") }
  end
end
