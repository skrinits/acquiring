# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Acquiring
  class Application < Rails::Application
    config.load_defaults 6.1

    config.generators do |generator|
      generator.template_engine :slim
      generator.test_framework :rspec, fixture: false, view: false
      generator.fixture_replacement :factory_bot, dir: 'spec/factories'
      generator.view_specs      false
      generator.helper_specs    false
    end
  end
end
