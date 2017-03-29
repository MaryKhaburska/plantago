class Rename < ActiveRecord::Migration[5.0]
  def change
    rename_column :apparats, :contacts, :contact
    rename_column :apparats, :contract, :company
  end
end
