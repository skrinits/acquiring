# frozen_string_literal: true

class TransactionView < BaseView
  def type
    object.type.sub('Transaction::', '')
  end

  def status
    object.status.upcase
  end

  def created_at
    view_context.l(object.created_at, format: :short)
  end

  def history
    build_consequence_transactions.each_with_object([]).each do |item, result|
      view = self.class.new(item, view_context)

      result.push(render_history_item(view))
    end.join(' => ')
  end

  private

  def render_history_item(view)
    %i[type status amount created_at].compact.map do |field|
      "#{field}: #{view.send(field)}"
    end.join(' ')
  end

  def build_consequence_transactions
    transactions = [object]

    loop do
      previous_transaction = transactions.first.previous_transaction

      break if previous_transaction.blank?

      transactions.unshift(previous_transaction)
    end

    transactions
  end
end
