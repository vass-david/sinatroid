# coding: utf-8

Gem::Specification.new do |s|
  s.name        = 'sinatroid'
  s.version     = '0.0.1'
  s.summary     = 'Sinatra template'
  s.description = "Sinatra template"
  s.authors     = 'Dávid Vass'
  s.email       = 'contact@davidvass.sk'
  s.files       =  Dir['lib/   *.rb']
  s.license     = 'MIT'

  #s.rubyforge_project = 'sinatroid'

  s.files       = `git ls-files`.split($/)
  s.executables = ['sinatroid']
  s.test_files  = s.files.grep(%r{^(test|spec|features)/})

  # base
  %w{sinatra sinatra-contrib}.each {|d| s.add_dependency d}

  # assets
  %w{slim redcarpet therubyracer coffee-script sass compass sinatra-asset-pipeline}.each {|d| s.add_dependency d}

  s.add_dependency 'i18n'

  # exception_mailer dependency
  s.add_dependency 'pony'

  # cl lib
  s.add_dependency 'clamp'
end
