FactoryBot.define do
  factory :user_point do
    point_earned { 100 }
    user
  end
end
