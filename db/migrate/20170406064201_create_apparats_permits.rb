class CreateApparatsPermits < ActiveRecord::Migration[5.0]
  def change
    create_table :apparats_permits do |t|
      t.string :role
      t.references :user, foreign_key: true
      t.references :apparat, foreign_key: true

      t.timestamps
    end
    add_index :apparats_permits, [:user_id, :apparat_id]
  end
end
