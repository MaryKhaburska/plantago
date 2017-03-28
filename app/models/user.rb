class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  validates :role, presence: true

  enum role: [:admin, :expert, :newbie]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :newbie
  end
end
