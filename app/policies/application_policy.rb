class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  private

    def current_apparat_role
      permit = user.apparats_permits.where(apparat_id: record.id).first
      permit.present? ? permit.role : "no_role"
    end

    def current_company_role
      permit = user.companies_permits.where(company: record).first
      permit.present? ? permit_role : "no_role"
    end

    def current_user_role
      if record.instance_of? Company
        user.admin? or current_company_role
      elsif record.instance_of? Apparat
        user.admin? or current_apparat_role
      else
        false
      end
    end
end
