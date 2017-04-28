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
      redirect_to @company, success: "Новий контакт створено."
    else
      render :new
    end
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      redirect_to company_contact_path(@contact.company, @contact), success: "Контакт змінено успішно."
    else
      render :edit
    end
  end

  def destroy
    @contact.destroy
    redirect_to @contact.company, success: "Контакт видалено успішно."
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :skype, :company_id, :default) 
  end

end
