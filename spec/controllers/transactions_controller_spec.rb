# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionsController do
  login_admin

  let!(:transaction) { create(:transaction_authorization) }

  describe 'GET #index' do
    render_views

    it 'render the view and returns 200 OK' do
      get :index

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    render_views

    it 'render the view and returns 200 OK' do
      get :show, params: { id: transaction.id }

      expect(response).to have_http_status(:ok)
    end
  end
end
