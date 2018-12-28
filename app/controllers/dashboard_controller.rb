class DashboardController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!
  def index
    @user = current_user
    @new_event = Event.new
    @new_place = Place.new
    @nav = true
  end
  
end
