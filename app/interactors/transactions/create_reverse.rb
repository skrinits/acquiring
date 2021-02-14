# frozen_string_literal: true

module Transactions
  class CreateReverse
    include RenderingErrors
    include Interactor

    delegate :params, :transaction, to: :context

    def call
      return unless params[:type] == 'reverse'

      context.transaction = build_transaction

      save(transaction) if transaction.valid?
      context.fail!(error: render_error(transaction)) if transaction.error? || transaction.invalid?
    end

    private

    def save(transaction)
      previous_transaction.with_lock do
        if previous_transaction.approved?
          reverse_previous_transaction
        else
          transaction.status = :error
        end

        transaction.save
      end
    end

    def render_error(transaction)
      transaction.persisted? ? "Previous transaction isn't approved" : render_api_error(transaction)
    end

    def build_transaction
      Transaction::Reverse.create(build_params)
    end

    def build_params
      result = params.slice(:uuid)

      result[:previous_transaction_id] = previous_transaction.id

      result
    end

    def previous_transaction
      @previous_transaction ||= Transaction::Authorization.find_by(
        uuid: params[:previous_transaction_uuid]
      )
    end

    def reverse_previous_transaction
      previous_transaction.update(status: :reversed)
    end
  end
end
