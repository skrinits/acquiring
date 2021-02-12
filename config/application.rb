# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Acquiring
  class Application < Rails::Application
    config.load_defaults 6.1

    config.generators do |g|
      g.template_engine :slim
      g.test_framework :rspec, fixture: false, view: false
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
      g.view_specs      false
      g.helper_specs    false
    end
  end
end
