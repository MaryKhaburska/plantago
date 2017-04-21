class AddLockedColumnToApparatsPermits < ActiveRecord::Migration[5.0]
  def change
    add_column :apparats_permits, :locked, :boolean, default: false
  end
end
