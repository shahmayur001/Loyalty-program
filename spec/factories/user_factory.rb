# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    date_of_birth { Faker::Date.in_date_period }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  trait :default_country do
    country { 'India' }
  end

  trait :other_country do
    country { Faker::Address.country }
  end
end
