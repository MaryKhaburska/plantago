class RemixApparatModel < ActiveRecord::Migration[5.0]
  def change
    remove_column :apparats, :company, :string
    add_index :apparats, :ip_address
    add_reference :apparats, :company, foreign_key: true
  end
end
