class AddDefaultValueToRoleInPermits < ActiveRecord::Migration[5.0]
  def change
    change_column :apparats_permits, :role, :integer, default: 0
    change_column :companies_permits, :role, :integer, default: 0
  end
end
