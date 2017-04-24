class Contact < ApplicationRecord
  belongs_to :company
  validates :name, presence: true
  
  has_and_belongs_to_many :apparts
end
