require_relative 'boot'

require 'csv'
require 'rails/all'

Bundler.require(*Rails.groups)

module Taskleaf
  class Application < Rails::Application
    config.load_defaults 5.2
    config.time_zone = 'Asia/Tokyo'
  end
end
