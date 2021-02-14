# frozen_string_literal: true

module Transaction
  class Charge < Base
    validates :amount, numericality: { greater_than: 0 }
  end
end
