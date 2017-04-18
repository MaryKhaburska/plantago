class CompaniesPermitsController < ApplicationController
  
  after_action :verify_authorized

  def create
    @user = User.find(params[:user_id])
    @companies_permit = @user.companies_permits.build(companies_permit_params)
    authorize @companies_permit
    if @companies_permit.save
      flash[:notice] = "User's role was successfully created."
      redirect_to @user
    else
      redirect_to @user 
    end
  end

  def update
    @companies_permit = CompaniesPermit.find(params[:id])
    authorize @companies_permit
    if @companies_permit.update_attributes(companies_permit_params)
      flash[:notice] = "User's role was successfully updated"
      redirect_to @companies_permit.user
    else
      flash[:danger] = "Role was not changed."
      redirect_to @user
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @companies_permit = @user.companies_permits.find(params[:id])
    authorize @companies_permit
    @companies_permit.destroy
    flash[:notice] = "User's role was successfully deleted"
    redirect_to @user
  end

  private

  def companies_permit_params
    params.require(:companies_permit).permit(:user_id, :company_id, :role)
  end
end
