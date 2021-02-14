# frozen_string_literal: true

module Transaction
  class Base < ApplicationRecord
    include HasUuid

    self.table_name = 'transactions'

    enum status: { approved: 0, reversed: 1, refunded: 2, error: 3 }

    validates :status, presence: true

    belongs_to :previous_transaction, class_name: 'Transaction::Base', optional: true
  end
end
