class ChangeColumnTypeToApparats < ActiveRecord::Migration[5.0]
  def change
    change_column :apparats, :product_type, :integer
  end
end
