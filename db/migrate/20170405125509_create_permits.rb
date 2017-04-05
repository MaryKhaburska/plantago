class CreatePermits < ActiveRecord::Migration[5.0]
  def change
    create_table :companies_permits do |t|
      t.string :role
      t.references :user, foreign_key: true
      t.references :company, foreign_key: true
    end
    add_index :companies_permits, [:user_id, :company_id]
  end
end
