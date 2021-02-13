# frozen_string_literal: true

class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      t.string :email, null: false
      t.string :encrypted_password
      t.timestamps
    end

    add_index :admins, :email, unique: true
  end
end
