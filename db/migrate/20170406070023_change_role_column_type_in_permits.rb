class ChangeRoleColumnTypeInPermits < ActiveRecord::Migration[5.0]
  def change
    change_table :companies_permits do |t|
      change_column :companies_permits, :role, :integer
    end
    
    change_table :apparats_permits do |t|
      change_column :apparats_permits, :role, :integer
    end
  end
end
