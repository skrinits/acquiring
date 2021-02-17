# frozen_string_literal: true

require 'rails_helper'

describe Merchants::Destroy do
  describe '.call' do
    subject(:result) { described_class.call(merchant: merchant) }

    context 'when a merchant has transactions' do
      let(:merchant) { create(:merchant, :with_transaction) }

      it { expect(result).to be_a_failure }
    end

    context 'when a merchant has no transactions' do
      let(:merchant) { create(:merchant) }

      it { expect(result).to be_a_success }
    end
  end
end
