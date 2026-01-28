source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Configuration
gem "dotenv-rails"
gem "config"

# Core
gem "pg"
gem "puma", "~> 3.11"
gem "rails", "~> 7.0.0"
gem "bootsnap", ">= 1.4.2", require: false

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :windows]
  
  # To run tests
  gem 'rspec-rails', '~> 7.0.0'
  gem "factory_bot_rails", "~> 6.5"
  gem "faker", "~> 3.5"
end

group :development do
  gem "listen", "~> 3.2"
end

# To Business Logic
gem "interactor", "~> 3.0"
