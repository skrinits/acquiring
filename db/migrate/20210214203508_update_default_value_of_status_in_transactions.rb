class UpdateDefaultValueOfStatusInTransactions < ActiveRecord::Migration[6.1]
  def change
    change_column_default :transactions, :status, 0
  end
end
