# frozen_string_literal: true

class CashRebatesJob < ApplicationJob
  queue_as :default

  # Perform job to assign 5% Cash Rebate Reward for specific users
  def perform
    users = User.joins(:transactions).group(:id).having('count(transactions.amount > 100) >= 10').select("users.id as user_id, #{reward_id} as reward_id").as_json
    UserReward.first_or_create(users)
  end

  # Used to find the specific reward
  def reward_id
    @reward_id ||= Reward.find_or_create_by(name: '5% Cash Rebate').id
  end
end
