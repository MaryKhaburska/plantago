class HomeController < ApplicationController

  def index
    @apparats_permit = ApparatsPermit.new
  end

end
