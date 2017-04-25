class AddDefaultColumnToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :default, :boolean, default: false 
  end
end
