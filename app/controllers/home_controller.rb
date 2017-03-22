class HomeController < ApplicationController
  def index
    @users = User.all
    @apparats = Apparat.all
  end
end
