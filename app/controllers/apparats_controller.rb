class ApparatsController < ApplicationController
  
  before_action :set_apparat, only: [:show, :edit, :update, :destroy, :update_description]
  after_action :verify_authorized, except: [:index, :update_description]
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
      flash[:notice] = "Item was successfully created."
    else
      render :new
    end
  end

  def update
    authorize @apparat
    if @apparat.update(apparat_params)
      redirect_to @apparat
      flash[:notice] = "Item was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    authorize @apparat
    @apparat.destroy
    redirect_to apparats_path
    flash[:notice] = "Item was successfully deleted."
  end

  def update_description
    @apparat = Apparat.find(params[:id])
    desc = "#{@apparat.description}\n\r#{params[:description]}"
    @apparat.update(description: desc)
    flash[:danger] = "Добавлено нову інформацію в опис."
    redirect_to @apparat 
  end

  private

    def set_apparat
      @apparat = Apparat.find(params[:id])
    end

    def apparat_params
      params.require(:apparat).permit(policy(@apparat).permitted_attributes)
    end
  
end
