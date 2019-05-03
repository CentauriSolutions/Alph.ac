# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Shorten
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil

    # Make sure CloudFlare IP addresses are
    # removed from the X-Forwarded-For header
    # before our app sees them
    #
    # These IPs come from https://www.cloudflare.com/ips/
    config.middleware.insert_before(Rails::Rack::Logger,
                                    RemoteIpProxyScrubber.filter_middleware,
                                    %w[
                                      173.245.48.0/20
                                      103.21.244.0/22
                                      103.22.200.0/22
                                      103.31.4.0/22
                                      141.101.64.0/18
                                      108.162.192.0/18
                                      190.93.240.0/20
                                      188.114.96.0/20
                                      197.234.240.0/22
                                      198.41.128.0/17
                                      162.158.0.0/15
                                      104.16.0.0/12
                                      172.64.0.0/13
                                      131.0.72.0/22
                                      2400:cb00::/32
                                      2606:4700::/32
                                      2803:f800::/32
                                      2405:b500::/32
                                      2405:8100::/32
                                      2a06:98c0::/29
                                      2c0f:f248::/32
                                    ])

    # Make sure the customer's real IP address (remote_ip)
    # is used in our Rails logs.
    config.middleware.insert_before(Rails::Rack::Logger, RemoteIpProxyScrubber.patched_logger)
    config.middleware.delete(Rails::Rack::Logger)
  end
end
