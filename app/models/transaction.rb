# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :user

  after_create :update_loyalty_points

  # Validation
  validates_presence_of :amount

  # Updating loyalty points on every transactions
  def update_loyalty_points
    UpdateLoyaltyPointsJob.perform_now(user.id, id)
  end
end
