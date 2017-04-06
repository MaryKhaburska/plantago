class RemoveRoleFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :role, :integer
    add_column :users, :admin, :boolean, default: false
  end
end
