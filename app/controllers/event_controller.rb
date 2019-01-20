class EventController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!
  
  def create
    @user = current_user
    @new_event = Event.new(event_params)
    startTime = params[:event][:start_date] + " " + params[:event][:start_time]
    endTime = params[:event][:end_date] + " " + params[:event][:end_time]
    Time.zone = "Berlin"
    @new_event.start_time = Time.zone.strptime(startTime, "%m/%d/%Y %H:%M")
    if @new_event.end_time != nil
      @new_event.end_time = Time.zone.strptime(endTime, "%m/%d/%Y %H:%M")
    end
    @new_event.save
    redirect_to root_path
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy!
    redirect_to root_path
  end
  
  def edit 
    @user = current_user
    @event = Event.find(params[:id])
  end
  
  def update
    @user = current_user
    @event = Event.find(params[:id])
    @event.update(event_params)
    Time.zone = 'Berlin'
    startTime = params[:event][:start_date] + " " + params[:event][:start_time]
    endTime = params[:event][:end_date] + " " + params[:event][:end_time]
    @event.start_time = Time.zone.strptime(startTime, "%m/%d/%Y %H:%M")
    if @event.end_time != nil
      @event.end_time = Time.zone.strptime(endTime, "%m/%d/%Y %H:%M")
    end
    @event.save
    redirect_to root_path
  end
  
  private
  
  def event_params
    params.require(:event).permit(:name, :description, :user_id, :place_id, :start_time, :end_time, :offer, :price, :ticket_url, :ticket_status, :pathname, :image_url, :start_date, :end_date, :image)
  end
end