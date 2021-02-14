# frozen_string_literal: true

module AuthHelper
  def http_login
    params = Rails.application.credentials[:test][:api][:transactions][:basic_authentication]

    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(
      params[:name], params[:password]
    )
  end
end

RSpec.configure do |config|
  config.include AuthHelper, type: :controller
end
