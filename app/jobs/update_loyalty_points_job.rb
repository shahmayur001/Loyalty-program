# frozen_string_literal: true

class UpdateLoyaltyPointsJob < ApplicationJob
  queue_as :default

  def initialize(user_id, transaction_id)
    @user_id = user_id
    @transaction_id = transaction_id
  end

  # Perform job to update loyalty points and loyalty tier
  def perform
    update_loyalty_points
    update_loyalty_tier
  end

  # Updating loyalty points based on the rule set
  def update_loyalty_points
    user.update(loyalty_points: generated_loyalty_points + user.loyalty_points)
    user.user_points.create(point_earned: generated_loyalty_points)
  end

  # Updating loyalty tier based on the loyalty points
  def update_loyalty_tier
    loyalty_tier =
      case user.loyalty_points
      when 0...1000
        'standard'
      when 1000...5000
        'gold'
      else
        'platinum'
      end
    user.update(loyalty_tier: loyalty_tier)
    AirportLoungeRewardsJob.perform_later(user.id) if user.gold?
  end

  # Generating loyalty points based on country and rule set
  def generated_loyalty_points
    (transaction_amount / 100 * (user.country == User::DEFAULT_COUNTRY ? 10 : 20))
  end

  # Fetchinbg user by user id
  def user
    @user ||= User.find(@user_id)
  end

  # Fetching the transaction amount for the specific transaction
  def transaction_amount
    @transaction_amount ||= Transaction.find(@transaction_id).amount
  end
end
