# frozen_string_literal: true

class AirportLoungeRewardsJob < ApplicationJob
  queue_as :default

  # Perform job to assign Airport Lounge Access Reward for specific users
  def perform(user_id)
    @user.user_rewards.create(reward_id: reward_id) if user(user_id).gold?
  end

  # Used to find the specific reward
  def reward_id
    @reward_id ||= Reward.find_or_create_by(name: 'Airport Lounge Access Reward').id
  end

  def user(id)
    @user ||= User.find(id)
  end
end
