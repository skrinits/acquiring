# frozen_string_literal: true

require 'rails_helper'

describe Transactions::CreateReverse do
  describe '.call' do
    subject(:result) { described_class.call(params: params) }

    let(:params) do
      body = file_fixture('reverse_transaction.xml').read

      Hash.from_xml(body)['transaction'].symbolize_keys
    end
    let!(:previous_transaction) { create(:transaction_authorization, uuid: params[:previous_transaction_uuid]) }
    let(:merchant) { previous_transaction.merchant }

    context 'when transaction is saved and approved' do
      it 'set transaction' do
        expect(result).to be_a_success
        expect(result.transaction).to be_present
      end

      it 'reverse a previous transaction' do
        expect(result).to be_a_success
        expect(previous_transaction.reload.reversed?).to eq(true)
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
