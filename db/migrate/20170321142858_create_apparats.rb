class CreateApparats < ActiveRecord::Migration[5.0]
  def change
    create_table :apparats do |t|
      t.string :name
      t.string :contract
      t.string :serial_number
      t.string :product_type
      t.text :description

      t.timestamps
    end
  end
end
