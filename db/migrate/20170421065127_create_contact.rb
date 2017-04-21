class CreateContact < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :name, null: false, index: true
      t.string :phone
      t.string :skype
      t.string :email
      t.references :company, foreign_key: true
      t.timestamps
    end
  end
end
