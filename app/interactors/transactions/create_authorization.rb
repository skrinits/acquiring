# frozen_string_literal: true

module Transactions
  class CreateAuthorization
    include RenderingErrors
    include Interactor

    delegate :params, :transaction, to: :context

    def call
      return unless params[:type] == 'authorization'

      context.transaction = create_transaction

      context.fail!(error: render_api_error(transaction)) unless transaction.persisted?
    end

    private

    def create_transaction
      Transaction::Authorization.create(
        creation_params
      )
    end

    def creation_params
      params.slice(:uuid, :customer_email, :customer_phone, :amount, :merchant_id)
    end
  end
end
