# frozen_string_literal: true

class Merchant < ApplicationRecord
  devise :database_authenticatable, :timeoutable, :validatable

  enum status: { inactive: 0, active: 1 }

  validates :total_transaction_sum, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true
  # additional checks of email format
  validates_with EmailAddress::ActiveRecordValidator

  has_many :transactions, class_name: 'Transaction::Base', dependent: :destroy
end
