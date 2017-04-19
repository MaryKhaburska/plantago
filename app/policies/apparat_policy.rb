class ApparatPolicy < ApplicationPolicy

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
      [:name, :company_id, :serial_number, :product_type, :description, :contact,
       :ip_address]
    elsif current_user_role == "writer"
      [:description]
    else
      false
    end
  end

  class Scope < Scope
    def resolve
      if  user.admin?
        scope.all
      else
        scope.where(id: user.apparats)
      end
    end    
  end
end
