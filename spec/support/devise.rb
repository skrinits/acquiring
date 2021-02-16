# frozen_string_literal: true

module ControllerMacros
  def login_admin
    before do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      sign_in FactoryBot.create(:admin)
    end
  end
end

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.extend ControllerMacros, type: :controller
end
