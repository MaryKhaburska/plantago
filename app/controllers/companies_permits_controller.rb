class CompaniesPermitsController < ApplicationController
  
  after_action :verify_authorized

  def create
    @user = User.find(params[:user_id])
    @companies_permit = @user.companies_permits.build(companies_permit_params)
    authorize @companies_permit
    if @companies_permit.save
      #@user.apparats << @companies_permit.company.apparats - @user.apparats
      create_apparat_role
      flash[:notice] = "User's role was successfully created."
      redirect_to @user
    else
      redirect_to @user 
    end
  end

  def update
    @user = User.find(params[:user_id])
    @companies_permit = CompaniesPermit.find(params[:id])
    authorize @companies_permit
    if @companies_permit.update_attributes(companies_permit_params)
      update_apparats_role(@user, @companies_permit)
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
    @user.apparats.delete(@companies_permit.company.apparats)
    flash[:notice] = "User's role was successfully deleted"
    redirect_to @user
  end

  private

    def create_apparat_role
      @companies_permit.company.apparats.map do |apparat|
        @user.apparats_permits.create(apparat: apparat, role: @companies_permit.role)
      end
    end

    def update_apparats_role(user, company_permit)
      company = company_permit.company
      role = company_permit.role
      user.apparats.where(company: company).map do |apparat|
        user.apparats_permits.find_by(apparat: apparat).role = role
      end
    end

    def companies_permit_params
      params.require(:companies_permit).permit(:user_id, :company_id, :role)
    end

end
