# frozen_string_literal: true

class AdduserIdIndexToUser < ActiveRecord::Migration[6.1]
  def change
    add_index :user_rewards, %i[user_id reward_id], unique: true
  end
end
