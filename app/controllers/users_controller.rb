class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
  
  def index
    @users = policy_scope User
     authorize User 
  end

  def show
    authorize @user
    @apparats = @user.apparats_permits
    @companies = @user.companies_permits
  end

  def update
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, notice: "User updated."
    else
      redirect_to users_path, alert: "Unable to update user."
    end
  end

  def destroy
    authorize @user
    user.destroy
    redirect_to users_path, notice: "User deleted."
  end

  private

  def secure_params
    params.require(:user).permit(:role)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
