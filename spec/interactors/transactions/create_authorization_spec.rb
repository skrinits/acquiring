# frozen_string_literal: true

require 'rails_helper'

describe Transactions::CreateAuthorization do
  describe '.call' do
    subject(:result) { described_class.call(params: params) }

    let(:params) do
      body = file_fixture('authorization_transaction.xml').read

      Hash.from_xml(body)['transaction'].symbolize_keys.merge(amount: 1_000)
    end

    context 'when transaction is saved' do
      before { create(:merchant, id: params[:merchant_id]) }

      it do
        expect(result).to be_a_success
        expect(result.transaction).to be_present
      end
    end

    context 'when transaction is not saved' do
      it do
        expect(result).to be_a_failure
        expect(result.error).to be_present
      end
    end
  end
end
