class HomeController < ApplicationController
  def index
    @apparats = Apparat.all
  end
end
