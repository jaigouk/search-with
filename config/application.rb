require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Jaigouk
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # Custom directories with classes and modules you want to be autoloadable.
    %i(app/services).each do |extra_path|
      load_path = "#{Rails.root}/#{extra_path}"
      config.autoload_paths << load_path
      config.eager_load_paths << load_path
    end
  end
end
