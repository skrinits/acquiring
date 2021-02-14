# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction::Authorization do
  subject(:authorization) { described_class.new }

  it_behaves_like 'models has uuid'
  it_behaves_like 'models transaction'

  describe 'Validations' do
    it 'validates amount' do
      expect(authorization).to validate_numericality_of(:amount).is_greater_than(0)
    end

    it 'validates customer_email' do
      expect(authorization).to validate_presence_of(:customer_email)
    end
  end
end
