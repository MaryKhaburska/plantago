module ApplicationHelper
  include ActionView::Helpers::TextHelper

  def current_role(record)
    if  !current_user.admin? and record.instance_of? Company
      current_user.companies_permits.find_by(company: record).role
    elsif !current_user.admin? and record.instance_of? Apparat
      current_user.apparats_permits.find_by(apparat: record).role
    else
      "Адміністратор"
    end
  end
end
