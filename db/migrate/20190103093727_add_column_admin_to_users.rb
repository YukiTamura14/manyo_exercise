class AddColumnAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean, defaule: false, null: false
  end
end
