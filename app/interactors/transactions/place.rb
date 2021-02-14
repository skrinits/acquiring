# frozen_string_literal: true

module Transactions
  class Place
    include Interactor::Organizer

    organize Transactions::ConvertParams,
             Transactions::CheckParams,
             Transactions::CreateAuthorization,
             Transactions::CreateCharge,
             Transactions::CreateRefund,
             Transactions::CreateReverse
  end
end
