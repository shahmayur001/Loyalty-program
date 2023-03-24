class CreateUserPoints < ActiveRecord::Migration[6.1]
  def change
    create_table :user_points do |t|
      t.integer :point_earned

      t.timestamps
    end
    add_reference :user_points, :user, null: false, foreign_key: true
  end
end
