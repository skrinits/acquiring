# frozen_string_literal: true

module Merchants
  class Destroy
    include Interactor

    delegate :merchant, to: :context

    def call
      if merchant.transactions.exists?
        context.fail!(error: 'The merchant has transactions')
      else
        merchant.destroy
      end
    end
  end
end
