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

  def update_description?
    current_user_role == "writer" or
    current_user_role == "expert" or 
    user.admin?
  end

  def add_contact?
    current_user_role == "writer" or 
    current_user_role == "expert" or 
    user.admin?
  end

  def permitted_attributes
    if user.admin? or current_user_role == "expert"
      [:name, :company_id, :serial_number, :product_type, :description,
       :ip_address, :contact_id]
    elsif current_user_role == "writer"
      [:description, :contact_id]
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
