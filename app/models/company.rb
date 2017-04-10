class Company < ApplicationRecord
  validates :name, presence: true
  has_many :apparats
  has_many :companies_permits
  has_many :users, through: :companies_permits
end
