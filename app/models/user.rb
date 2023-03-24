# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :transactions, dependent: :destroy
  has_many :user_rewards, dependent: :destroy
  has_many :rewards, through: :user_rewards
  has_many :user_points, dependent: :destroy

  # Validation
  validates_presence_of :first_name, :last_name, :country, :date_of_birth, :email

  DEFAULT_COUNTRY = 'India'

  enum loyalty_tier: { standard: 0, gold: 1, platinum: 2 }
end
