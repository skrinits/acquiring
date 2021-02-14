# frozen_string_literal: true

module Transactions
  class DestroyOld
    include Interactor

    SAVING_PERIOD = 1.hour

    def call
      load_transactions.destroy_all
    end

    private

    def load_transactions
      Transaction::Base.where('created_at < ?', SAVING_PERIOD.ago)
    end
  end
end
