class ApparatsPermit < ApplicationRecord
  belongs_to :user
  belongs_to :apparat

  enum role: [:newbie, :expert, :admin ]
end
