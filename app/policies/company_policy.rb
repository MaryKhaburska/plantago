class CompanyPolicy < ApplicationPolicy

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

   def destroy?
    user.admin?
   end

  def permitted_attributes
    if user.admin?
      [:name, :description, :phone]
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
