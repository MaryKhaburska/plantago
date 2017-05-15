class ApparatsController < ApplicationController
  
  before_action :set_apparat, only: [:show, :edit, :update, :destroy, 
                                     :update_description, :add_contact,
                                     :remove_contact]
  after_action :verify_authorized, except: [:index, :update_description]
  after_action :verify_policy_scoped, only: [:index ]
  
  def index
    @apparats = policy_scope(Apparat)
    @apparats = @apparats.company(params[:company_id]) if params[:company_id].present?
    @apparats = @apparats.product_type(params[:product_type]) if params[:product_type].present?
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
      flash[:success] = "Item was successfully created."
    else
      render :new
    end
  end

  def update
    authorize @apparat
    if @apparat.update(apparat_params)
      redirect_to @apparat
      flash[:success] = "Item was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    authorize @apparat
    @apparat.destroy
    redirect_to apparats_path
    flash[:success] = "Item was successfully deleted."
  end

  def update_description
    date = DateTime.now.strftime("%Y-%m-%d %H:%m")
    desc = "#{@apparat.description}\n\r#{date} (#{current_user.name}): #{params[:description]}"
    @apparat.update(description: desc)
    flash[:success] = "Добавлено нову інформацію в опис."
    redirect_to @apparat 
  end

  def add_contact
    authorize @apparat
    @contact = Contact.find(params[:contact_id])
    @apparat.contacts << @contact
    flash[:success] = "Новий контакт добавлено."
    redirect_to @apparat
  end
  
  def remove_contact
    authorize @apparat
    contact = Contact.find(params[:contact_id])
    @apparat.contacts.delete(contact)
    redirect_to @apparat
  end

  def goto
    if Apparat.where(id: params[:id]).exists?
      set_apparat
      authorize @apparat
      redirect_to @apparat
    else
      authorize Apparat
      flash[:danger] = "В базі нема пристрою з номером #{params[:id]}."
      redirect_to root_path
    end
  end

  private

    def set_apparat
      @apparat = Apparat.find(params[:id])
    end

    def apparat_params
      params.require(:apparat).permit(policy(Apparat).permitted_attributes)
    end
  
end
