class ApparatsPermitsController < ApplicationController
  
  after_action :verify_authorized

  def create
    @user = User.find(params[:user_id])
    @apparats_permit = @user.apparats_permits.build(apparats_permit_params)
    authorize @apparats_permit
    if @apparats_permit.save
      flash[:success] = "User's role was successfully created."
      redirect_to @user
    else
      render :new 
    end
  end

  def update
    @apparats_permit = ApparatsPermit.find(params[:id])
    authorize @apparats_permit
    if @apparats_permit.update_attributes(apparats_permit_params)
      flash[:success] = "User's role was successfully updated"
      redirect_to @apparats_permit.user
    else
      flash[:danger] = "Role was not changed."
      redirect_to @user
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @apparats_permit = @user.apparats_permits.find(params[:id])
    authorize @apparats_permit
    @apparats_permit.destroy
    flash[:success] = "User's role was successfully deleted"
    redirect_to @user
  end

  private

  def apparats_permit_params
    params.require(:apparats_permit).permit(:user_id, :apparat_id, :role, :locked)
  end
end
