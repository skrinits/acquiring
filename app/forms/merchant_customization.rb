# frozen_string_literal: true

class MerchantCustomization < BaseForm
  validates :status, presence: true
  validates :name, presence: true
  validate :check_email

  attr_accessor :name, :description, :email, :status, :merchant

  def update
    return unless valid?

    update_merchant
  end

  private

  def update_merchant
    merchant.update(
      name: name, description: description, email: email, status: status
    )
  end

  def check_email
    return unless email.blank? || !EmailAddress.valid?(email)

    errors.add(:email, 'invalid')
  end
end
