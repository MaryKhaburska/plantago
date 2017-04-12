class CompanyPolicy < ApplicationPolicy
  
  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve 
      if user.admin?
        scope.all  
      else
        scope.where(id: user.companies_permits)
      end
    end
  end
end
