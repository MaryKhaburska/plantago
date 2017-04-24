class CreateApparatsContactsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :apparats_contacts do |t|
      t.belongs_to :apparat, index: true
      t.belongs_to :contact, index: true
    end
  end
end
