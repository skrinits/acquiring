# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    status { 'approved' }
    amount { rand(100..1_000) }
    customer_email { "#{FFaker::Lorem.characters[0..10]}@gmail.com" }
    uuid { Digest::UUID.uuid_v4 }
    customer_phone { FFaker::PhoneNumber.phone_number }

    trait :approved do
      status { :approved }
    end

    trait :reversed do
      status { :reversed }
    end

    trait :refunded do
      status { :refunded }
    end

    trait :error do
      status { :error }
    end

    factory :transaction_authorization, class: 'Transaction::Authorization' do
      merchant
    end

    factory :transaction_charge, class: 'Transaction::Charge' do
    end

    factory :transaction_refund, class: 'Transaction::Refund' do
    end

    factory :transaction_reverse, class: 'Transaction::Reverse' do
    end
  end
end
