class AddExpiredAtColumnToTasks < ActiveRecord::Migration[5.2]
  def up
    add_column :tasks, :expired_at, :date, null: false, default: -> { 'NOW()' }
  end

  def down
    change_column :tasks, :expired_at, :date, null: true, default: -> { 'NOW()' }
  end
end
