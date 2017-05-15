class ApparatPolicy < ApplicationPolicy

  def create?
    true
  end

  def update?
    user.admin? or current_user_role == "expert"
  end

  def destroy?
    false
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

  def remove_contact?
    current_user_role == "writer" or
    current_user_role == "expert" or
    user.admin?
  end

  def goto?
    true
  end

  def permitted_attributes
    [:name, :company_id, :serial_number, :product_type, :description,
     :ip_address, :contact_id]
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
