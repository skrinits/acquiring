# frozen_string_literal: true

FactoryBot.define do
  factory :admin do
    email { "#{FFaker::Lorem.characters[0..10]}@gmail.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
