# frozen_string_literal: true

module Transactions
  class CreateCharge
    include RenderingErrors
    include Interactor

    delegate :params, :transaction, to: :context

    def call
      return unless params[:type] == 'charge'

      context.transaction = build_transaction

      save(transaction) if transaction.valid?
      context.fail!(error: render_error(transaction)) if transaction.error? || transaction.invalid?
    end

    private

    def save(transaction)
      previous_transaction.with_lock do
        if previous_transaction.approved?
          increase_merchant_total_sum(transaction.amount)
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
      Transaction::Charge.new(build_params)
    end

    def build_params
      result = params.slice(:uuid, :amount)

      result[:previous_transaction_id] = previous_transaction.id

      result
    end

    def previous_transaction
      @previous_transaction ||= Transaction::Authorization.find_by(uuid: params[:previous_transaction_uuid])
    end

    def increase_merchant_total_sum(amount)
      merchant.with_lock do
        merchant.total_transaction_sum += amount

        merchant.save!
      end
    end

    def merchant
      @merchant ||= previous_transaction.merchant
    end
  end
end
