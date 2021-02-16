# frozen_string_literal: true
include FactoryBot::Syntax::Methods

def create_admins
  Admin.create(email: 'admin@mail.ru', password: 'password', password_confirmation: 'password')
end


def create_transactions_and_merchants
  10.times {
    transaction_authorization = create(:transaction_authorization)
    transaction_charge = create(:transaction_charge, previous_transaction: transaction_authorization)
    transaction_authorization.merchant.update(total_transaction_sum: transaction_charge.amount)
  }

  10.times {
    transaction_authorization = create(:transaction_authorization)
    transaction_charge = create(:transaction_charge, :refunded, previous_transaction: transaction_authorization)
    transaction_refund = create(:transaction_refund, previous_transaction: transaction_charge)
    create(:transaction_refund, :error, previous_transaction: transaction_charge)
  }

  10.times {
    transaction_authorization = create(:transaction_authorization, :reversed)
    transaction_reverse = create(:transaction_reverse, previous_transaction: transaction_authorization)
    create(:transaction_reverse, :error, previous_transaction: transaction_authorization)
  }
end

create_admins
create_transactions_and_merchants
