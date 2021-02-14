# frozen_string_literal: true

module Transaction
  class Refund < Base
    validates :amount, numericality: { greater_than: 0 }
  end
end
