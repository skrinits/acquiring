# frozen_string_literal: true

require 'rails_helper'

describe Transactions::ConvertParams do
  describe '.call' do
    subject(:result) { described_class.call(format: format, body: body) }

    let(:xml_body) { file_fixture('authorization_transaction.xml').read }
    let(:converted_params) do
      { type: 'authorization', customer_email: 'test@mail.ru',
        customer_phone: '+7(911)111-11-11', amount: 1000, merchant_id: '1' }
    end

    context 'when format is json' do
      let(:format) { :json }
      let(:body) { Hash.from_xml(xml_body).to_json }

      it do
        expect(result.params).to eq(converted_params)
      end
    end

    context 'when format is xml' do
      let(:format) { :xml }
      let(:body) { xml_body }

      it do
        expect(result.params).to eq(converted_params)
      end
    end
  end
end
