# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.timestamps
    end
    add_reference :transactions, :user, null: false, foreign_key: true
  end
end
