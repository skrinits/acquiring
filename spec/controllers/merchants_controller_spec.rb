# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MerchantsController do
  login_admin

  let!(:merchant) { create(:merchant) }

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
      get :show, params: { id: merchant.id }

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE #destroy' do
    let(:result) { Interactor::Context.new }

    context 'when result with success' do
      before do
        allow(Merchants::Destroy).to receive(:call).and_return(result).and_call_original
        allow(result).to receive(:success?).and_return(true)
      end

      it do
        delete :destroy, params: { id: merchant.id }

        expect(response).to redirect_to(merchants_path)
      end
    end

    context 'when result with failure' do
      before do
        allow(Merchants::Destroy).to receive(:call).and_return(result)
        allow(result).to receive(:success?).and_return(false)
      end

      it do
        delete :destroy, params: { id: merchant.id }

        expect(response).to redirect_to(merchant_path(merchant))
      end
    end
  end
end
