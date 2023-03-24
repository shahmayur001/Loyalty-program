# frozen_string_literal: true

class UserPoint < ApplicationRecord
  belongs_to :user

  # Validation
  validates_presence_of :point_earned
end
