# frozen_string_literal: true

FactoryBot.define do
  factory :merchant do
    name { FFaker::Name.name }
    description { FFaker::Lorem.sentence }
    email { "#{FFaker::Lorem.characters[0..10]}@gmail.com" }
    password { 'password' }
    password_confirmation { 'password' }
    status { 'active' }

    trait :with_transaction do
      transient do
        type { :authorization }
      end

      after :create do |merchant, evaluator|
        merchant.transactions << create("transaction_#{ evaluator.type }")
      end
    end

    trait :active do
      status { :active }
    end

    trait :inactive do
      status { :inactive }
    end
  end
end
