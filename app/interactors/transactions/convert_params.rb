# frozen_string_literal: true

module Transactions
  class ConvertParams
    include Interactor

    delegate :format, :body, to: :context

    def call
      params = format == :json ? convert_json : convert_xml
      params[:amount] = params[:amount].to_f if params.key?(:amount)

      context.params = params
    end

    private

    def convert_json
      JSON.parse(body)['transaction'].symbolize_keys
    end

    def convert_xml
      Hash.from_xml(body)['transaction'].symbolize_keys
    end
  end
end
