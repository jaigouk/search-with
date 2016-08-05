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
# https://github.com/twbs/bootstrap-rubygem
gem 'bootstrap', '~> 4.0.0.alpha3.1'
source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
end

gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1.7'
# gem 'capistrano-rails', group: :development
gem "ffaker"

gem "readthis"
gem "kaminari"
gem "active_model_serializers", "0.10.1"

## scenic & materialized view
gem "redis"
gem "hiredis"
gem "scenic"
gem "textacular"

## searchkick
gem 'searchkick', '~> 0.9.1'

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
  gem "guard-rspec", "~> 4.7"

  gem "scss_lint", require: false
  gem "brakeman", require: false
  gem "bundler-audit", require: false

  gem "foreman"
  gem "factory_girl_rails"

  gem "spring"
  gem "spring-commands-rspec"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

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
end
