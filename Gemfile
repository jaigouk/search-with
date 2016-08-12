source 'https://rubygems.org'
ruby "2.3.1"

gem 'rails', '~> 5.0.0.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sidekiq'
gem 'rack-protection', git: 'https://github.com/sinatra/rack-protection.git'
gem 'sinatra', git: 'https://github.com/sinatra/sinatra.git', require: false

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'therubyracer', platforms: :ruby
gem "font-awesome-rails"
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'sunspot_rails'
gem 'bootstrap', '~> 4.0.0.alpha3.1'
source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
end
gem 'bcrypt', '~> 3.1.7'
gem "ffaker"
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'web-console', group: :development
gem "readthis"
gem "kaminari"
gem "active_model_serializers"

## Cache
gem "redis"
gem "hiredis"
gem 'rack-cache'
gem 'dalli'
gem 'kgio'

## Benchmark / Performance
gem 'stackprof'
gem 'memory_profiler'
# gem 'kalibera', require: false
gem 'benchmark-ips', '~> 2.6.1'
gem 'derailed_benchmarks', '~> 1.3'
gem 'mime-types'
gem "flamegraph"
gem 'rack-mini-profiler', require: false
gem "bullet", :group => "development"

## scenic & materialized view
gem "scenic"
gem "textacular", git: 'https://github.com/DuckNG/textacular.git', branch: 'support-rails-5.0.0.1'

## searchkick
gem 'searchkick'

## algolia
gem "algoliasearch-rails"

group :development, :test do
  gem 'dotenv-rails'
  gem "database_cleaner"
  gem "generator_spec"
  gem "launchy"

  gem 'sunspot_solr'

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
  gem 'simplecov', :require => false
  gem 'codacy-coverage', :require => false
  gem "rspec", "= 3.5.0.beta3"
  gem "rspec-core", "= 3.5.0.beta3"
  gem "rspec-expectations", "= 3.5.0.beta3"
  gem "rspec-mocks", "= 3.5.0.beta3"
  gem "rspec-support", "= 3.5.0.beta3"
  gem "rspec-rails", "3.5.0.beta3"
  gem "rspec-retry"
  gem 'shoulda-matchers', '~> 3.1'
end
