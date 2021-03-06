class Apparat < ApplicationRecord
  validates :name, presence: true
  enum product_type: [:phones, :computer_laptop, :server, :thin_client, :router, :switch, 
                      :printer_scanner_mfp, :internet_settings, :other_information]
  belongs_to :company, optional: true
  has_many :apparats_permits, dependent: :destroy
  has_many :users, through: :apparats_permits
  has_and_belongs_to_many :contacts

  scope :product_type, -> (product_type) { where product_type: product_type }
  scope :company, -> (company_id) { where company_id: company_id }
  scope :desc_fragment, -> (desc_fragment) { where "description like ?", "%#{desc_fragment}%" }

  def not_added_contacts
    if self.company.present?
      self.company.contacts - self.contacts
    else
      []
    end
  end

  def users_without_permit
    User.all - self.users
  end
end
