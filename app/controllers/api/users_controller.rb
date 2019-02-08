class Api::UsersController < ApplicationController
  before_action :set_location, :refresh_event_status, :check_payment
  
  def show
  end
  
  private
  
  def set_location
    @user = User.find(params[:id])
  end
  
  def refresh_event_status
    @user.events.each do |event|
      if event.end_time < Time.now && event.status != "beendet"
        event.status = "beendet"
        event.save!
        UserMailer.with(user: @user, event: event).event_beendet.deliver_now
      end
  end
    
end