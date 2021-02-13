# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Merchant do
  subject(:merchant) { described_class.new }

  describe 'Validations' do
    it 'validates total_transaction_sum' do
      expect(merchant).to validate_numericality_of(:total_transaction_sum).is_greater_than_or_equal_to(0)
    end

    it 'validates status' do
      expect(merchant).to validate_presence_of(:status)
    end
  end
end
