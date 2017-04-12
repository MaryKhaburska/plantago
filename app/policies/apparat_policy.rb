class ApparatPolicy < ApplicationPolicy

  def create?
    user.admin?
  end

  def update?
    user.admin?
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

  private

    def current_role(record)
      if record.instance_of? Company
        self.companies_permits.find_by(company_id: record.id).role
      elsif record.instance_of? Apparat
        self.apparats_permits.find_by(apparat_id: record.id).role
      end
    end
    
end
