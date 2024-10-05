source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.3'


gem 'rails', '~> 6.1.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'jquery-rails'
gem 'devise'
gem 'cocoon'
gem 'octokit', '~> 4.0'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'slim-rails'
gem 'skim'
gem 'gon'
gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-vkontakte'
gem 'omniauth-rails_csrf_protection'
gem 'cancancan'
gem 'doorkeeper'
gem 'active_model_serializers', '~> 0.10.0'
gem 'oj'
gem 'sidekiq', '6.5.5'
gem 'sinatra', require: false
gem 'whenever', require: false
gem 'thinking-sphinx'
gem 'mysql2'
gem 'database_cleaner'
gem 'redis', '~> 4.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 4.1.0'
  gem 'factory_bot_rails'
  gem "aws-sdk-s3", require: false
  gem 'capybara-email'
  gem 'letter_opener'
  gem 'capistrano', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-passenger', require: false
  gem 'ed25519', '>= 1.2', '< 2.0'
  gem 'net-ssh', '>= 6.0.2'
  gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'
  gem 'capistrano-sidekiq', require: false
  gem 'capistrano3-unicorn', require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  #gem 'chromedriver-helper'
  # Easy installation and use of web drivers to run system tests with browsers
  #gem 'webdrivers'
  gem 'shoulda-matchers'
  gem 'rails-controller-testing'
  gem 'launchy'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
