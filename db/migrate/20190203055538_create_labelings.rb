# frozen_string_literal: true

class CreateLabelings < ActiveRecord::Migration[5.2]
  def change
    create_table :labelings do |t|
      t.references :task, null: false, foreign_key: true
      t.references :label, null: false, foreign_key: true
    end
 end
end
