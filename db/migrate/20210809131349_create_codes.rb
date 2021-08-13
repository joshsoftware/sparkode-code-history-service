# frozen_string_literal: true

class CreateCodes < ActiveRecord::Migration[6.1]
  def change
    create_table :codes do |t|
      t.text :answer
      t.integer :language_id, null: false
      t.string :token, null: false
      t.integer :problem_id, null: false
      t.timestamps
    end
  end
end
