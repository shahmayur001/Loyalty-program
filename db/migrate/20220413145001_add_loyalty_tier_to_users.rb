class AddLoyaltyTierToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :loyalty_tier, :integer, default: 0
  end
end
