class CompaniesPermit < ApplicationRecord
  belongs_to :user
  belongs_to :company

  enum role: [:newbie, :writer, :expert]
end
