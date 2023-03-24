# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :country
      t.integer :loyalty_points, default: 0
      t.datetime :date_of_birth

      t.timestamps
    end
  end
end
