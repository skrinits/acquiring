# frozen_string_literal: true

FactoryBot.define do
  factory :merchant do
    name { FFaker::Name.name }
    description { FFaker::Lorem.sentence }
    email { "#{FFaker::Lorem.characters[0..10]}@gmail.com" }
    password { 'password' }
    password_confirmation { 'password' }
    status { 'active' }

    trait :active do
      status { :active }
    end

    trait :inactive do
      status { :inactive }
    end
  end
end
