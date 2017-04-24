class Apparat < ApplicationRecord
  validates :name, presence: true
  enum product_type: [:phones, :computer_laptop, :server, :thin_client, :router, :switch, 
                      :printer_scanner_mfp, :internet_settings, :other_information]
  belongs_to :company
  has_many :apparats_permits, dependent: :destroy
  has_many :users, through: :apparats_permits
  has_and_belongs_to_many :contacts
end
