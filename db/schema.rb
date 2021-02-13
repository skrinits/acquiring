# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_13_132007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "merchants", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "email", null: false
    t.string "encrypted_password"
    t.integer "status", null: false
    t.money "total_transaction_sum", scale: 2, default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_merchants_on_email", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.uuid "uuid", null: false
    t.string "type", null: false
    t.integer "status", null: false
    t.string "customer_email", null: false
    t.string "customer_phone", null: false
    t.money "amount", scale: 2, null: false
    t.bigint "merchant_id", null: false
    t.bigint "previous_transaction_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["merchant_id"], name: "index_transactions_on_merchant_id"
    t.index ["previous_transaction_id"], name: "index_transactions_on_previous_transaction_id"
    t.index ["uuid"], name: "index_transactions_on_uuid", unique: true
  end

  add_foreign_key "transactions", "merchants"
end
