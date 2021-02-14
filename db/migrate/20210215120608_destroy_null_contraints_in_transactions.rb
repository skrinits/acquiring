class DestroyNullContraintsInTransactions < ActiveRecord::Migration[6.1]
  def change
    change_column_null :transactions, :customer_email, true
    change_column_null :transactions, :customer_phone, true
    change_column_null :transactions, :amount, true
    change_column_null :transactions, :merchant_id, true
  end
end
