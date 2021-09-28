# frozen_string_literal: true

require_relative "lib/omniauth/smaregi/version"

Gem::Specification.new do |spec|
  spec.required_ruby_version = ">= 2.7.0"
  spec.name          = "omniauth-smaregi"
  spec.version       = Omniauth::Smaregi::VERSION
  spec.authors       = ["ntakanashi"]
  spec.email         = ["ntakanashi725@gmail.com"]

  spec.summary       = "Smaregi OAuth2 Strategy for OmniAuth"
  spec.description   = spec.summary
  spec.homepage      = "http://github.com/ntakanashi/omniauth-smaregi"
  spec.license       = "MIT"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "oauth2", "~> 1.1"
  spec.add_runtime_dependency "omniauth", "~> 2.0"
  spec.add_runtime_dependency "omniauth-oauth2", "~> 1.7.1"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.7"
end
