# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.uuid :uuid, null: false
      t.string :type, null: false
      t.integer :status, null: false
      t.string :customer_email, null: false
      t.string :customer_phone, null: false
      t.money :amount, null: false

      t.belongs_to :merchant, null: false, foreign_key: true, index: true
      t.belongs_to :previous_transaction, index: true

      t.timestamps
    end

    add_index :transactions, :uuid, unique: true
  end
end
