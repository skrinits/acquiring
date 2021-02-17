# frozen_string_literal: true

# would be placed in admin folder
class MerchantCustomizationsController < ApplicationController
  before_action :authenticate_admin!
  before_action :load_merchant

  def new
    @customization = MerchantCustomization.new(merchant: @merchant)
  end

  def create
    @customization = MerchantCustomization.new(
      merchant_customization_params.merge(merchant: @merchant)
    )

    if @customization.update
      redirect_to merchant_path(@merchant), notice: 'successfully updated'
    else
      respond_with @customization
    end
  end

  private

  def load_merchant
    @merchant = Merchant.find(params[:id])
  end

  def merchant_customization_params
    params.require(:merchant_customization).permit(:name, :description, :email, :status)
  end
end
