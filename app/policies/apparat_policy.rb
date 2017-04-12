class ApparatPolicy < ApplicationPolicy
  def create?
    user.admin?
  end

  def update?
    user.admin? or current_user_role == "expert"
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if  user.admin?
        scope.all
      else
        scope.where(id: user.apparats_permits)
      end
    end    
  end
end
