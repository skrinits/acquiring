# frozen_string_literal: true

module Transaction
  class Base < ApplicationRecord
    include HasUuid

    self.abstract_class = true
    self.table_name = 'transactions'

    enum status: { approved: 0, reversed: 1, refunded: 2, error: 3 }

    validates :amount, numericality: { greater_than: 0 }
    validates :customer_email, presence: true
    validates_with EmailAddress::ActiveRecordValidator, field: :customer_email
    validates :status, presence: true

    belongs_to :merchant
    belongs_to :previous_transaction, class_name: 'Transaction::Base', optional: true
  end
end
