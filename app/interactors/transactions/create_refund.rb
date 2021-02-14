# frozen_string_literal: true

module Transactions
  class CreateRefund
    include RenderingErrors
    include Interactor

    delegate :params, :transaction, to: :context

    def call
      return unless params[:type] == 'refund'

      context.transaction = build_transaction

      save(transaction) if transaction.valid?
      context.fail!(error: render_error(transaction)) if transaction.error? || transaction.invalid?
    end

    private

    def save(transaction)
      previous_transaction.with_lock do
        if previous_transaction.approved?
          decrease_merchant_total_sum(transaction.amount)
          refund_previous_transaction
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
      Transaction::Refund.new(build_params)
    end

    def build_params
      result = params.slice(:uuid, :amount)

      result[:status] = :error unless previous_transaction.approved?
      result[:previous_transaction_id] = previous_transaction.id

      result
    end

    def previous_transaction
      @previous_transaction ||= Transaction::Charge.includes(previous_transaction: :merchant).find_by(
        uuid: params[:previous_transaction_uuid]
      )
    end

    def decrease_merchant_total_sum(amount)
      merchant.with_lock do
        merchant.total_transaction_sum -= amount

        merchant.save!
      end
    end

    def merchant
      @merchant ||= previous_transaction.previous_transaction.merchant
    end

    def refund_previous_transaction
      previous_transaction.update(status: :refunded)
    end
  end
end
