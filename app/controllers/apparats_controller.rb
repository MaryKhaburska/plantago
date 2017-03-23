class ApparatsController < ApplicationController
  def index
    @apparats = Apparat.all
  end
end
