# frozen_string_literal: true

class Admin < ApplicationRecord
  devise :database_authenticatable, :timeoutable, :validatable

  # additional checks of email format
  validates_with EmailAddress::ActiveRecordValidator
end
