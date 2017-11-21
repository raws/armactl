Gem::Specification.new do |s|
  s.name = 'armactl'
  s.version = '0.0.1'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Ross Paffett']
  s.email = ['ross@rosspaffett.com']
  s.homepage = 'https://github.com/raws/armactl'
  s.summary = 'A tool for managing an ArmA 3 dedicated server'
  s.description = 'A tool for managing an ArmA 3 dedicated server'
  s.license = 'MIT'
  s.files = Dir['lib/**/*.rb']
  s.require_path = 'lib'
  s.executables = ['armactl', 'armactl-init']

  s.add_development_dependency 'fakefs', '~> 0.11.3'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 3.7.0'
end
