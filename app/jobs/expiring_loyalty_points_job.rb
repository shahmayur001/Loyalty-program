# frozen_string_literal: true

class ExpiringLoyaltyPointsJob < ApplicationJob
  queue_as :default

  # Perform job to expire loyalty points at the end of every year
  def perform
    User.where('created_at <= ?', Date.today - 1.year).update_all(loyalty_points: 0)
  end
end
