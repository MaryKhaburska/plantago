class HomeController < ApplicationController
  def index
    @users = User.all
    @apparats = Apparat.all
  end

  def users
    @users = User.all
  end

end
