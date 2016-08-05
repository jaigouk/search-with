source 'https://rubygems.org'
ruby "2.3.1"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'therubyracer', platforms: :ruby
gem "font-awesome-rails"
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'bootstrap', '~> 4.0.0.alpha3.1'
gem 'tether-rails'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1.7'
# gem 'capistrano-rails', group: :development
gem "ffaker"
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'web-console', group: :development

gem "readthis"
gem "kaminari"
gem "active_model_serializers"

## scenic & materialized view
gem "redis"
gem "hiredis"
gem "scenic"
gem "textacular"

## searchkick
gem 'searchkick'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem "database_cleaner"
  gem "generator_spec"
  gem "launchy"

  gem "pry"
  gem "pry-doc"
  gem "pry-rails"
  gem "pry-stack_explorer"
  gem "pry-rescue"
  gem "pry-byebug"
  gem "guard-rspec"

  gem "scss_lint", require: false
  gem "brakeman", require: false
  gem "bundler-audit", require: false

  gem "foreman"
  gem "factory_girl_rails"

  gem "spring"
  gem "spring-commands-rspec"
  gem 'spring-watcher-listen'
  gem 'listen'
end

group :test do
  gem "rspec", "= 3.5.0.beta3"
  gem "rspec-core", "= 3.5.0.beta3"
  gem "rspec-expectations", "= 3.5.0.beta3"
  gem "rspec-mocks", "= 3.5.0.beta3"
  gem "rspec-support", "= 3.5.0.beta3"
  gem "rspec-rails", "3.5.0.beta3"
  gem "rspec-retry"
  gem 'shoulda-matchers', '~> 3.1'
  gem "codeclimate-test-reporter", require: nil
  gem 'simplecov', require: nil
end
