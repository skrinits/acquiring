# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MerchantCustomizationsController do
  login_admin

  let!(:merchant) { create(:merchant) }

  describe 'GET #new' do
    render_views

    it 'render the view and returns 200 OK' do
      get :new, params: { id: merchant.id }

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    context 'when updated with success' do
      it do
        post :create, params: { id: merchant.id, merchant_customization: attributes_for(:merchant) }

        expect(response).to redirect_to(merchant_path(merchant))
      end
    end

    context 'when updated with failure' do
      it do
        post :create, params: { id: merchant.id, merchant_customization: attributes_for(:merchant, status: nil) }

        expect(response).to render_template(:new)
      end
    end
  end
end
