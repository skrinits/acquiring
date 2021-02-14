# frozen_string_literal: true

require 'rails_helper'

describe Transactions::CreateCharge do
  describe '.call' do
    subject(:result) { described_class.call(params: params) }

    let(:params) do
      body = file_fixture('charge_transaction.xml').read

      Hash.from_xml(body)['transaction'].symbolize_keys.merge(amount: 1_000)
    end
    let!(:previous_transaction) { create(:transaction_authorization, uuid: params[:previous_transaction_uuid]) }
    let(:merchant) { previous_transaction.merchant }

    context 'when transaction is saved and approved' do
      it 'set transaction' do
        expect(result).to be_a_success
        expect(result.transaction).to be_present
      end

      it 'increase a merchant total_transaction_sum' do
        expect(result).to be_a_success
        expect(merchant.reload.total_transaction_sum).to eq(1_000)
      end
    end

    context 'when transaction is not saved' do
      before { params[:amount] = 0 }

      it do
        expect(result).to be_a_failure
        expect(result.error).to be_present
      end
    end

    context 'when transaction is set to error status' do
      before do
        previous_transaction.update(status: :reversed)
      end

      it do
        expect(result).to be_a_failure
        expect(result.error).to be_present
        expect(result.transaction.error?).to eq(true)
      end
    end
  end
end
