class ContactPolicy < ApplicationPolicy
  
  def create?
    true
  end

  def update? 
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
