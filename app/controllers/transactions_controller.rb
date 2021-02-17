# frozen_string_literal: true

# would be placed in admin folder
class TransactionsController < ApplicationController
  include Collectionable

  before_action :authenticate_admin!

  def index
    transactions = Transaction::Base.order(created_at: :desc).page(params[:page])

    @transactions = wrap_in_view_models(TransactionView, transactions)
  end

  def show
    transaction = Transaction::Base.find(params[:id])

    @transaction = TransactionView.new(transaction, view_context)
  end
end
