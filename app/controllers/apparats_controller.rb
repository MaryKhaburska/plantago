class ApparatsController < ApplicationController
  
  before_action :set_apparat, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
  
  def index
    @apparats = policy_scope Apparat
  end

  def new
    @apparat = Apparat.new
    authorize @apparat
  end

  def edit
    authorize @apparat
  end

  def show
    authorize @apparat
  end

  def create
    @apparat = Apparat.new(apparat_params)
    authorize @apparat
    if @apparat.save
      redirect_to @apparat
      flash[:notice] = "Apparat was successfully created."
    else
      render :new
    end
  end

  def update
    authorize @apparat
    if @apparat.update(apparat_params)
      redirect_to @apparat
      flash[:notice] = "Apparat was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    authorize @apparat
    @apparat.destroy
    redirect_to apparats_path
    flash[:notice] = "Apparat was successfully deleted."
  end

  private

    def set_apparat
      @apparat = Apparat.find(params[:id])
    end

    def apparat_params
      params.require(:apparat).permit(policy(@apparat).permitted_attributes)
    end
  
end
