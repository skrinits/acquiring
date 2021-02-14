# frozen_string_literal: true

module Transactions
  class CheckParams
    include Interactor

    delegate :params, to: :context

    def call
      merchant = Merchant.find(params[:merchant_id])

      context.fail!(error: 'Merchant is inactive') if merchant.inactive?
    end
  end
end
