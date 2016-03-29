$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'admin4rails/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'admin4rails'
  s.version     = Admin4rails::VERSION
  s.authors     = ['Mirko Mignini']
  s.email       = ['m.mignini@wepush.org']
  s.homepage    = 'TODO'
  s.summary     = 'TODO: Summary of Admin4rails.'
  s.description = 'TODO: Description of Admin4rails.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 4.2.5'
  s.add_dependency 'coffee-rails', '~> 4.1.0'
  s.add_dependency 'hamlit'
  s.add_dependency 'easydsl'
  s.add_dependency 'font-awesome-rails'
  s.add_dependency 'bootstrap-sass', '~> 3.3.6'
  s.add_dependency 'sass-rails', '~> 5.0'
  s.add_dependency 'datagrid'
  s.add_dependency 'kaminari'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'capybara'
end
