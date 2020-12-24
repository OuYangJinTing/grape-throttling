# frozen_string_literal: true

require_relative 'lib/grape/throttling/version'

Gem::Specification.new do |spec|
  spec.name          = 'grape-throttling'
  spec.version       = Grape::Throttling::VERSION
  spec.authors       = ['OuYangJinTing']
  spec.email         = ['2729877005qq@gmail.com']

  spec.summary       = 'Grape rate limit exceeded.'
  spec.description   = 'Grape rate limit exceeded.'
  spec.homepage      = 'https://github.com/OuYangJinTing/grape-throttling'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  # spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/OuYangJinTing/grape-throttling.git'
  spec.metadata['changelog_uri'] = 'https://github.com/OuYangJinTing/grape-throttling/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'grape', '>= 0.16.1'
  spec.add_runtime_dependency 'redis-namespace', '>= 0.8.0'
  spec.add_runtime_dependency 'hiredis'
  spec.add_runtime_dependency 'activesupport', '>= 3'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'minitest-reporters'
  # The higher rubocop do not support ruby-2.3
  spec.add_development_dependency 'rubocop', '~> 0.81.0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.6.1'
  spec.add_development_dependency 'rubocop-minitest'
  # spec.add_development_dependency 'rubocop-packaging'
end
