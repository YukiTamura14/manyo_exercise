# frozen_string_literal: true

class AddColumnPriorityToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :priority, :integer, null: false, default: 1
    add_index :tasks, :priority
  end
end
