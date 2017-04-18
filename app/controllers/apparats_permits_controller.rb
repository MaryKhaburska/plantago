class ApparatsPermitsController < ApplicationController
  
  after_action :verify_authorized

#  def new
#    @apparats_permit = Apparats_permit.new
#    authorize @apparats_permit
#  end
 
  def create
    @user = User.find(apparats_permit_params[:user_id])
    @apparats_permit = @user.apparats_permits.build(apparats_permit_params)
    authorize @apparats_permit
    if @apparats_permit.save
      flash[:notice] = "User's role was successfully created."
      redirect_to @user
    else
      render "home/index"
    end
  end

  def update
    @apparats_permit = Apparats_permit.find(params[:id])
    authorize @apparats_permit
    if @apparats_permit.update(apparats_permit_params)
      flash[:notice] = "User's role was successfully updated"
      redirect_to @user
    else
      render "home/index"
    end
  end

  def destroy
    @apparats_permit = Apparats_permit.find(params[:id])
    authorize @apparats_permit
    flash[:notice] = "User's role was successfully deleted"
    redirect_to @user
  end

  private

  def apparats_permit_params
    params.require(:apparats_permit).permit(:user_id, :apparat_id, :role)
  end
end
