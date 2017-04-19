class CompanyPolicy < ApplicationPolicy

  def create?
    user.admin?
  end

  def update?
    user.admin? or current_user_role == "expert" or current_user_role == "writer"
  end

   def destroy?
    user.admin?
  end

  def permitted_attributes
    if user.admin? or current_user_role == "expert"
      [:name, :description, :phone]
    elsif current_user_role == "writer"
      [:description]
    else
      false
    end
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user.companies)
      end
    end
  end
end
