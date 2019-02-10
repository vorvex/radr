class DashboardController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!
  def index
    @user = current_user
    check_payment
    check_plan  
    @new_event = Event.new
    @new_place = Place.new
    @nav = true
  end 
  
end
