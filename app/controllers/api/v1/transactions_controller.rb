# frozen_string_literal: true

module Api
  # :reek:UncommunicativeModuleName
  module V1
    class TransactionsController < ApplicationController
      skip_before_action :verify_authenticity_token

      http_basic_authenticate_with(
        Rails.application.credentials[Rails.env.to_sym][:api][:transactions][:basic_authentication]
      )

      def create
        respond_to do |format|
          format.json { render_json }
          format.xml { render_xml }
        end
      end

      private

      def render_json
        result = place_transaction(:json)

        render json: result.failure? ? { error: result.error } : { success: { uuid: result.transaction.uuid } }
      end

      def render_xml
        result = place_transaction(:xml)

        render xml: [result.failure? ? { error: result.error } : { success: { uuid: result.transaction.uuid } }]
      end

      def place_transaction(format)
        Transactions::Place.call(body: request.body.read, format: format)
      end
    end
  end
end
