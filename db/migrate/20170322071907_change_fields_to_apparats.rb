class ChangeFieldsToApparats < ActiveRecord::Migration[5.0]
  def change
    add_column :apparats, :contacts, :string
    add_column :apparats, :ip_address, :string
  end
end
