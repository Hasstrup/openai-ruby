# frozen_string_literal: true

require_relative "lib/openai/version"

Gem::Specification.new do |spec|
  spec.name = "openai-ruby"
  spec.version = OpenAI::VERSION
  spec.authors = ["Hasstrup Ezekiel"]
  spec.email = ["hasstrup.ezekiel@gmail.com"]

  spec.summary = "A library for interacting with the OpenAI API"
  spec.description = "A library for interacting with the OpenAI API"
  spec.homepage = "https://github.com/Hasstrup/openai-ruby"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Hasstrup/openai-ruby"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    %x(git ls-files -z).split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", ">= 0.17.3"

  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "rubocop", "~> 1.52"
  spec.add_development_dependency "rubocop-rspec", "~> 2.22.0"
  spec.add_development_dependency "rubocop-shopify", "~> 2.13.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
