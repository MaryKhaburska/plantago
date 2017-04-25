class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
  
  def index
    @users = policy_scope User
  end

  def new
    @user = User.new
    authorize @user
  end

  def edit
    authorize @user
  end

  def create
    @user = User.new(secure_params)
    authorize @user
    if @user.save
      redirect_to @user, notice: "Нового користувача створено."
    else
      render :new
    end
  end

  def show
    authorize @user
    @permited_apparats = @user.apparats_permits
    @permited_companies = @user.companies_permits
  end

  def update
    authorize @user
    if @user.update(secure_params)
      redirect_to @user, notice: "Інформацію користувача оновлено."
    else
      render :edit
    end
  end

  def destroy
    authorize @user
    @user.destroy
    redirect_to users_path, notice: "Користувача видалено."
  end

  private

  def secure_params
    params.require(:user).permit(:name, :email, :admin, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
