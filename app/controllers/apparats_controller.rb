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
    @apparats = @apparats.desc_fragment(params[:desc_fragment]) if params[:desc_fragment].present?
    @apparats_size = @apparats.size

    respond_to do |format|
      format.html { @apparats }
      format.js
    end
  end

  def new
    @apparat = Apparat.new
    authorize @apparat
  end

  def edit
    @users = User.all
    @permits = @apparat.apparats_permits
    authorize @apparat
  end

  def show
    @users = User.all
    @permits = @apparat.apparats_permits
    authorize @apparat
  end

  def create
    @apparat = Apparat.new(apparat_params)
    @company = Company.find(params[:company_id]) if params[:company_id].present?
    authorize @apparat
    if @apparat.save
      create_permit @apparat
      redirect_to right_redirect
      flash[:success] = "Новий пристрій створено."
    else
      render :new
    end
  end

  def update
    authorize @apparat
    if @apparat.update(apparat_params)
      redirect_to right_redirect
      flash[:success] = "Інформацію про пристрій оновлено."
    else
      render :edit
    end
  end

  # def destroy
  #   authorize @apparat
  #   @apparat.destroy
  #   redirect_to apparats_path
  #   flash[:success] = "Item was successfully deleted."
  # end

  def update_description
    date = DateTime.now.strftime("%Y-%m-%d %H:%m")
    desc = "#{@apparat.description}\n\r#{date} (#{current_user.name}): #{params[:description]}"
    @apparat.update(description: desc)
    flash[:success] = "Добавлено нову інформацію в опис."
    redirect_to right_redirect
  end

  def add_contact
    authorize @apparat
    @contact = Contact.find(params[:contact_id])
    @apparat.contacts << @contact
    respond_to do |format|
      format.html { redirect_to right_redirect }
      format.js
      format.json { render json: @apparat.errors, status: :unprocessable_entity }
    end
  end
  
  def remove_contact
    authorize @apparat
    contact = Contact.find(params[:contact_id])
    @apparat.contacts.delete(contact)
    respond_to do |format|
      format.html { redirect_to right_redirect @apparat }
      format.js
      format.json { render json: @apparat.errors, status: :unprocessable_entity }
    end
  end

  def goto
    if Apparat.where(id: params[:id]).exists?
      set_apparat
      authorize @apparat
      redirect_to right_redirect
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

    # Create permit for new apparat. If current_user has permits on assigned
    # company he will get the same role in this apparat. If user admin - 
    # don't create any permits.
    def create_permit(apparat)
      unless current_user.admin?
      company = Company.find(apparat_params[:company_id]) if apparat_params[:company_id].present?
        if company and current_user.companies_permits.find_by(company: company)
          role = current_user.companies_permits.find_by(company: company).role
        else
          role = "newbie"
        end
        apparat.apparats_permits.create(user: current_user, role: role)
      end
    end

    # Determine redirect path depend on user policy.
    def right_redirect
      if policy(@apparat).update?
        edit_apparat_path(@apparat)
      else
        @apparat
      end
    end
end
