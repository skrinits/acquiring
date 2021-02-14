# frozen_string_literal: true

require 'rails_helper'

describe Transactions::CheckParams do
  describe '.call' do
    subject(:call) { described_class.call(params: params) }

    let(:params) { { merchant_id: merchant.id } }

    before { allow(Merchant).to receive(:find).with(merchant.id).and_return(merchant) }

    context 'when merchant is active' do
      let(:merchant) { build_stubbed(:merchant, :active) }

      it { expect(call).to be_a_success }
    end

    context 'when merchant is inactive' do
      let(:merchant) { build_stubbed(:merchant, :inactive) }

      it do
        result = call

        expect(result).to be_a_failure
        expect(result.error).to eq('Merchant is inactive')
      end
    end
  end
end
