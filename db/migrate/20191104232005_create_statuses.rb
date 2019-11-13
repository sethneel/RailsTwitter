# frozen_string_literal: true

class CreateStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :statuses do |t|
      t.references :user, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
