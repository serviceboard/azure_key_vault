# frozen_string_literal: true

require_relative "lib/azure_kv/version"

Gem::Specification.new do |spec|
  spec.name          = "azure_kv"
  spec.version       = AzureKV::VERSION
  spec.authors       = ["Miroslav Kralik"]
  spec.email         = ["miroslav.kralik@serviceboard.to"]

  spec.summary       = "API wrapper for Azure Key Vault"
  spec.description   = "The Azure Key Vault REST APIs are used to manage secrets in Azure Key Vault.
                        This gem provides a simple interface to the REST APIs."
  spec.homepage      = "https://github.com/serviceboard/azure_kv"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.4")
  spec.add_dependency "faraday", "~> 2.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/serviceboard/azure_kv"
  spec.metadata["changelog_uri"] = "https://github.com/serviceboard/azure_kv/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
