class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def new
    @company = Company.find(params[:company_id])
    @contact = @company.contacts.build
  end

  def edit
    @company = Company.find(params[:company_id])
    @contact = Contact.find(params[:id]) 
  end

  def create
    @company = Company.find(params[:company_id])
    @contact = @company.contacts.create(contact_params)
    if @contact.save
      flash[:success] = "Новий контакт створено."
      right_redirect
    else
      render :new
    end
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      flash[:success] = "Контакт відредаговано."
      right_redirect
    else
      render :edit
    end
  end

  def destroy
    @contact.destroy
    flash[:success] = "Контакт видалено."
    right_redirect
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :skype, :company_id, :default) 
  end

  def right_redirect
    if current_user.admin?
      redirect_to edit_company_path(@contact.company)
    else
      redirect_to @contact.company
    end
  end
end
