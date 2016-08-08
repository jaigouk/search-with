ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?

if ENV['CODACY_PROJECT_TOKEN']
  require 'simplecov'
  SimpleCov.start 'rails'
  puts "required simplecov"
  require 'codacy-coverage'
  Codacy::Reporter.start
  puts "required codacy-coverage"
end

require 'spec_helper'
require 'rspec/rails'
require 'sunspot/rails/spec_helper'

ActiveRecord::Migration.maintain_test_schema!

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

# https://github.com/sunspot/sunspot/wiki/RSpec-and-Sunspot
Sunspot.session = Sunspot::Rails::StubSessionProxy.new(Sunspot.session)

# require 'vcr'

# VCR.configure do |config|
#   config.cassette_library_dir = "spec/vcr_cassettes"
#   config.hook_into :webmock # or :fakeweb
# end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:each, es: true) do
    reindex_searchkick
  end

end

def reindex_searchkick
  if Activity.searchkick_index.exists?
    Activity.searchkick_index.delete
    Activity.reindex
  end
end

def populate_5_activities_1
  Activity.delete_all
  5.times do |i|
    tag = FactoryGirl.create(:tag)
    bool = (1..3).include?(i) ? true : false
    activity = FactoryGirl.create(:activity, title: "Searchkick #{i}", camp: bool, drop_in: true)
    location = FactoryGirl.create(:location)
    FactoryGirl.create(:activity_tag, tag: tag, activity: activity)
    FactoryGirl.create(:activity_location, location: location, activity: activity)
  end
  reindex_searchkick
end

def populate_5_activities_2
  Activity.delete_all
  (1..5).to_a.each do |i|
    query = (1..3).include?(i) ? "Starwars" : "Startreck"
    about = "Master Yoda said, Do. Or do not. There is no try." if i == 3
    bool = (2..3).include?(i) ? true : false

    tag = create(:tag)
    activity = create(:activity, title: "Searchkick #{query}", about: about, camp: bool, indoor: true)
    location = create(:location)

    create(:activity_tag, tag: tag, activity: activity)
    create(:activity_location, location: location, activity: activity)
  end
  reindex_searchkick
end
