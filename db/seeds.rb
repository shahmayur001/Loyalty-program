# frozen_string_literal: true

require 'faker'
include FactoryBot::Syntax::Methods

# Creating test user used for login
user = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: 'test@gmail.com', password: 'Simform@123',
                   date_of_birth: Faker::Date.in_date_period, country: 'India')

# Creating basic Rewards which can be used in the applications
rewards = [{ name: '5% Cash Rebate' },
           { name: 'Free Coffee_Reward' },
           { name: 'Free Movie ticket' },
           { name: 'Airport Lounge Access Reward' }]

Reward.create(rewards)

# Creating 20 test users
create_list :user, 10, :default_country

create_list :user, 10, :other_country

# Creating 10 transactions for the users
create_list :transaction, 10, user_id: user.id
