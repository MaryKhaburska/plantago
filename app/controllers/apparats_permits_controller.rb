class ApparatsPermitsController < ApplicationController
  
  after_action :verify_authorized

  def create
    @user = User.find(params[:user_id])
    @apparat = Apparat.find(apparats_permit_params[:apparat_id])
    @apparats_permit = @user.apparats_permits.build(apparats_permit_params)
    authorize @apparats_permit
    if @apparats_permit.save
      respond_to do |format|
        format.html {redirect_to @user, success: "Новий дозвіл створено успішно."}
        format.js
      end
    else
      respond_to do |format|
        format.html {render :new}
        format.js
      end
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
    if @apparats_permit.destroy
      respond_to do |format|
        format.html {redirect_to @user, success: "User's role was successfully deleted" }
        format.js
      end
    end
  end

  private

  def apparats_permit_params
    params.require(:apparats_permit).permit(:user_id, :apparat_id, :role, :locked)
  end
end
