class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = Contacts.all
  end

  def show
  end

  def new
    @contact = Contact.new
  end

  def edit
  end

  def create
    @contact = Contact.new(user_params)
    if @contact.save
      redirect_to @contact, notice: "Новий контакт створено."
    else
      render :new
    end
  end

  def update
    if @contact.update(contact_params)
      redirect_to @user, notice: "Контакт змінено успішно."
    else
      render :edit
    end
  end

  def destroy
    @contact.destroy
    redirect_to contacts_url, notice: "Контакт видалено успішно."
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:user).permit(:name, :email, :phone, :skype) 
  end

end
