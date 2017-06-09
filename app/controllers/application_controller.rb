class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveModel::RangeError, with: :entered_too_big_number

  private

    def entered_too_big_number
      flash[:danger] = "Введено надто велике число."
      redirect_to(request.referrer || root_path)
    end

    def user_not_authorized
      flash[:danger] = "Недостатньо прав доступу."
      redirect_to(request.referrer || root_path)
    end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end
end
