# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TransactionsController do
  before { http_login }

  describe 'POST #create' do
    let(:xml_request) { file_fixture('authorization_transaction.xml').read }
    let(:result) { Interactor::Context.new }
    let(:transaction) { build_stubbed(:transaction_authorization) }

    before { allow(Transactions::Place).to receive(:call).and_return(result) }

    context 'if format is xml' do
      it 'call interactor' do
        result[:transaction] = transaction

        post :create, format: :xml, body: xml_request

        expect(Transactions::Place).to have_received(:call).with(body: xml_request, format: :xml)
      end

      context 'and the interactor has success' do
        before { result[:transaction] = transaction }

        it do
          post :create, format: :xml, body: xml_request

          expect(response.body).to include("<uuid>#{transaction.uuid}</uuid>")
        end
      end

      context 'and the interactor has failure' do
        before do
          result.error = 'test_error'
          allow(result).to receive(:failure?).and_return(true)
        end

        it do
          post :create, format: :xml, body: xml_request

          expect(response.body).to include('<error>test_error</error>')
        end
      end
    end

    context 'if format is json' do
      let(:json_request) { Hash.from_xml(xml_request).to_json }

      it 'call interactor' do
        result[:transaction] = transaction

        post :create, format: :json, body: json_request

        expect(Transactions::Place).to have_received(:call).with(body: json_request, format: :json)
      end

      context 'and the interactor has success' do
        before { result[:transaction] = transaction }

        it do
          post :create, format: :json, body: json_request

          expect(response.body).to include_json(success: { uuid: transaction.uuid })
        end
      end

      context 'and the interactor has failure' do
        before do
          result.error = 'test_error'
          allow(result).to receive(:failure?).and_return(true)
        end

        it do
          post :create, format: :json, body: json_request

          expect(response.body).to include_json(error: 'test_error')
        end
      end
    end
  end
end
