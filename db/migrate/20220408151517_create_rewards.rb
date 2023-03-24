# frozen_string_literal: true

class CreateRewards < ActiveRecord::Migration[5.2]
  def change
    create_table :rewards do |t|
      t.string :name

      t.timestamps
    end
  end
end
