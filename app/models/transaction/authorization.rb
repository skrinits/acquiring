# frozen_string_literal: true

module Transaction
  class Authorization < Base
    validates :customer_email, presence: true
    validates_with EmailAddress::ActiveRecordValidator, field: :customer_email
    validates :amount, numericality: { greater_than: 0 }

    belongs_to :merchant
  end
end
