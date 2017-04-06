class CompaniesPermit < ApplicationRecord
  belongs_to :user
  belongs_to :company

  enum role: [:newbie, :expert, :admin ]
end
