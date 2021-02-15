# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController do
  login_admin

  describe 'GET #index' do
    render_views

    it 'render the view and returns 200 OK' do
      get :index

      expect(response).to have_http_status(200)
    end
  end
end
