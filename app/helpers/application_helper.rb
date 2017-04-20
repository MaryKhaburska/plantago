module ApplicationHelper
  include ActionView::Helpers::TextHelper

  def current_role(record)
    if record.instance_of? Company
      current_user.companies_permits.find_by(company: record).role
    elsif record.instance_of? Apparat
      current_user.apparats_permits.find_by(apparat: record).role
    end
  end
end
