class ContactPolicy < ApplicationPolicy
  
  def create?
    current_user_role == "expert" or user.admin?
  end

  def update? 
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
