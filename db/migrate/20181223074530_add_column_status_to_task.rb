# frozen_string_literal: true

class AddColumnStatusToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :status, :integer, null: false, default: 1
    add_index :tasks, :status
  end
end
