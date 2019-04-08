# frozen_string_literal: true

class ChangeColumnNullTasks < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :name, :string, null: false
    change_column :tasks, :detail, :text, null: false
  end

  def down
    change_column :tasks, :name, :string, null: true
    change_column :tasks, :detail, :text, null: true
  end
end
