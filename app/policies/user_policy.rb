class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    # return false if current_user == user
    user.admin?
  end

  class Scope < Scope
    def resolve
      if  user.admin?
        scope.all
      end
    end    
  end
end
