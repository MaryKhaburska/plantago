class ApparatsController < ApplicationController
  
  before_action :set_apparat, only: [:show, :edit, :update, :destroy]
  
  def index
    @apparats = Apparat.all
  end

  def new
    @apparat = Apparat.new
  end

  def edit
  end

  def create
    @apparat = Apparat.new(apparat_params)

    if @apparat.save
      redirect_to @apparat
      flash[:notice] = "Apparat was successfully created."
    else
      render :new
    end
  end

  def update
    if @apparat.update(apparat_params)
      redirect_to @apparat
      flash[:notice] = "Apparat was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @apparat.destroy
    redirect_to apparats_path
    ulash[:notice] = "Apparat was successfully deleted."
  end

  private

    def set_apparat
      @apparat = Apparat.find(params[:id])
    end

    def apparat_params
      params.requiure(:apparat).permit(:name)
    end
end
