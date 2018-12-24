class DashboardController < ApplicationController
  layout "dashboard"
#  before_action :authenticate_user!
  def index
    @user = User.first
    @new_event = Event.new
    @new_place = Place.new
  end
  
end
