source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'devise'
gem 'jbuilder', '~> 2.5'
gem 'kaminari'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'rubocop', '~> 0.51.0', require: false
gem 'sass-rails', '~> 5.0'
gem 'simple_form'
gem 'slim'
gem 'uglifier', '>= 1.3.0'
# Use SCSS for stylesheets
gem 'bootstrap', '~> 4.0.0.beta2.1'
gem 'feathericon-sass'
gem 'font-awesome-sass', '~> 4.7.0'
gem 'jquery-rails'
gem 'sprockets-rails', require: 'sprockets/railtie'

group :development, :test do
  gem 'annotate'
  gem 'any_login'
  gem 'byebug', '~> 9.0', '>= 9.0.6'
  gem 'capybara', '~> 2.13'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry', '~> 0.10.3'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 3.6'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'vcr'
  gem 'webmock'    
end

group :development do
  gem 'capistrano', '~> 3.6'
  gem 'capistrano-passenger'
  gem 'capistrano-rails', '~> 1.3'
  gem 'capistrano-rails-collection'
  gem 'capistrano-rails-db'
  gem 'capistrano-rvm'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', '~> 1.2017', '>= 1.2017.3'
