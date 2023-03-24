# frozen_string_literal: true

class CoffeeRewardsJob < ApplicationJob
  queue_as :default

  # Perform job to assign Free Coffee_Reward for specific users
  def perform
    users = User.joins(:user_points).where('user_points.created_at BETWEEN ? AND ?', 
                                            DateTime.now.beginning_of_month, DateTime.now.end_of_month).group(:id)
                                            .having('SUM(user_points.point_earned) >= ? OR extract(month from date_of_birth) = ?', 100, DateTime.now.month)
                                            .select("users.id as user_id, #{reward_id} as reward_id").as_json
    UserReward.first_or_create(users)
  end

  # Used to find the specific reward
  def reward_id
    @reward_id ||= Reward.find_or_create_by(name: 'Free Coffee_Reward').id
  end
end
