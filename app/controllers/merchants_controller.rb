# frozen_string_literal: true

# would be placed in admin folder
class MerchantsController < ApplicationController
  include Collectionable

  before_action :authenticate_admin!
  before_action :load_merchant, only: %i[show destroy]

  def index
    @merchants = Merchant.order(id: :desc).page(params[:page])
  end

  def show; end

  def destroy
    result = Merchants::Destroy.call(merchant: @merchant)

    if result.success?
      respond_with @merchant
    else
      redirect_to({ action: :show }, alert: result.error)
    end
  end

  private

  def load_merchant
    @merchant = Merchant.find(params[:id])
  end
end
