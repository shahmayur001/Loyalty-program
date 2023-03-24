# frozen_string_literal: true

class BonusPointsJob < ApplicationJob
  queue_as :default

  # Perform job to provide bonus points for specific users
  def perform
    users = User.joins(:transactions).where('transactions.created_at BETWEEN ? AND ? and transactions.amount >= ?',
                                            Date.today.beginning_of_quarter, Date.today.end_of_quarter, 2000)
    users.update_all('loyalty_points = (loyalty_points + 100)')
  end
end
