class CompaniesPermitsController < ApplicationController
  
  after_action :verify_authorized

  def create
    @user = User.find(params[:user_id])
    @companies_permit = @user.companies_permits.build(companies_permit_params)
    authorize @companies_permit
    if @companies_permit.save
      # create_apparat_role
      flash[:success] = "User's role was successfully created."
      redirect_to @user
    else
      render :new 
    end
  end

  def update
    @user = User.find(params[:user_id])
    @companies_permit = CompaniesPermit.find(params[:id])
    authorize @companies_permit
    if @companies_permit.update_attributes(companies_permit_params)
      update_apparats_role
      flash[:success] = "User's role was successfully updated"
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
    flash[:success] = "User's role was successfully deleted"
    redirect_to @user
  end

  private

    # def create_apparat_role
    #   @companies_permit.company.apparats.map do |apparat|
    #     @user.apparats_permits.
    #       create(apparat: apparat, role: @companies_permit.role)
    #   end
    # end
    
    def create_apparats_roles(user, company)
      apparats = company.apparats 
    end

    def update_apparats_role
      company = @companies_permit.company
      role = @companies_permit.role
      @user.apparats.where(company: company).map do |apparat|
        perm = @user.apparats_permits.find_by(apparat: apparat)
        perm.role = role if !perm.locked?
        perm.save
      end
    end

    def companies_permit_params
      params.require(:companies_permit).permit(:user_id, :company_id, :role)
    end
end
