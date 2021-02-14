# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction::Charge do
  subject(:charge) { described_class.new }

  it_behaves_like 'models has uuid'
  it_behaves_like 'models transaction'

  describe 'Validations' do
    it 'validates amount' do
      expect(charge).to validate_numericality_of(:amount).is_greater_than(0)
    end
  end
end
