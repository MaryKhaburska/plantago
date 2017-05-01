class Company < ApplicationRecord
  validates :name, presence: true
  has_many :apparats
  has_many :companies_permits, dependent: :destroy
  has_many :users, through: :companies_permits
  has_many :contacts, dependent: :destroy
end
