class HomeController < ApplicationController

  def index
  end

  def demo
  end

  def users
    @users = User.all
  end

end
