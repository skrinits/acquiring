# frozen_string_literal: true

require 'rails_helper'

describe Transactions::CreateRefund do
  describe '.call' do
    subject(:result) { described_class.call(params: params) }

    let(:params) do
      body = file_fixture('refund_transaction.xml').read

      Hash.from_xml(body)['transaction'].symbolize_keys.merge(amount: 1_000)
    end
    let(:transaction_authorization) { create(:transaction_authorization) }
    let!(:previous_transaction) do
      create(
        :transaction_charge,
        previous_transaction: transaction_authorization,
        uuid: params[:previous_transaction_uuid]
      )
    end
    let(:merchant) { transaction_authorization.merchant }

    context 'when transaction is saved and approved' do
      before { merchant.update(total_transaction_sum: 5_000) }

      it 'set transaction' do
        expect(result).to be_a_success
        expect(result.transaction).to be_present
      end

      it 'decrease a merchant total_transaction_sum' do
        expect(result).to be_a_success
        expect(merchant.reload.total_transaction_sum).to eq(4_000)
      end

      it 'refund a previous transaction' do
        expect(result).to be_a_success
        expect(previous_transaction.reload.refunded?).to eq(true)
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
      before { previous_transaction.update(status: :reversed) }

      it do
        expect(result).to be_a_failure
        expect(result.error).to be_present
        expect(result.transaction.error?).to eq(true)
      end
    end
  end
end
