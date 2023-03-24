# frozen_string_literal: true

class CreateUserRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :user_rewards do |t|
      t.bigint :user_id
      t.bigint :reward_id

      t.timestamps
    end
  end
end
