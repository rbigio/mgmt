source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.0.rc1'

gem 'pg'
gem 'github_api'
gem 'haml-rails'
gem 'jquery-rails'
gem 'simple_form', github: 'plataformatec/simple_form'
gem 'devise', github: 'plataformatec/devise', branch: 'rails4'
gem 'omniauth'
gem 'omniauth-github'
gem 'inherited_resources'
gem 'app_configuration'
gem 'unicorn'
gem 'foreman'
gem 'coveralls', require: false
gem 'option'
gem 'i18n-js'
gem 'underscore-rails'

group :assets do
  gem 'sprockets-rails',  github: 'rails/sprockets-rails'
  gem 'coffee-rails',     github: 'rails/coffee-rails'
  gem 'therubyracer',     platforms: :ruby
  gem 'less-rails',       github: 'metaskills/less-rails'
  gem 'twitter-bootstrap-rails'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'watchr'
end

group :test, :development do
  # Debugging
  gem 'pry'
  gem 'debugger'
  gem 'debugger-pry'
  gem 'pry-nav'
  gem 'pry-stack_explorer'

  # Testing
  gem 'timecop'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'faker'
  # gem 'cucumber-rails', '~>1.3.0', :require => false
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
end
