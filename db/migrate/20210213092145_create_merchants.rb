# frozen_string_literal: true

class CreateMerchants < ActiveRecord::Migration[6.1]
  def change
    create_table :merchants do |t|
      t.string :name
      t.text :description
      t.string :email, null: false
      t.string :encrypted_password
      t.integer :status, null: false
      t.money :total_transaction_sum, default: 0

      t.timestamps
    end

    add_index :merchants, :email, unique: true
  end
end
