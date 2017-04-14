class MakeIdexesUniqueInPermitsTables < ActiveRecord::Migration[5.0]
  def change
    remove_index :apparats_permits, [:user_id, :apparat_id]
    add_index :apparats_permits, [:user_id, :apparat_id], unique: true
    remove_index :companies_permits, [:user_id, :company_id]
    add_index :companies_permits, [:user_id, :company_id], unique: true
  end
end
