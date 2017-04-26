class CompaniesController < ApplicationController
  
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    @companies = policy_scope Company
  end

  def new
    @company = Company.new
    authorize @company
  end

  def edit
    authorize @company
  end

  def show
    authorize @company
  end

  def create
    @company = Company.new(company_params)
    authorize @company
    if @company.save
      redirect_to companies_path
      flash[:success] = "Company was successfully created."
    else
      render :new
    end
  end

  def update
    authorize @company
    if @company.update(company_params)
      redirect_to @company
      flash[:success] = "Company was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    authorize @company
    @company.destroy
    redirect_to companies_path
    flash[:success] = "Company was successfully deleted."
  end

  private

    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(policy(Company).permitted_attributes)
    end
end
