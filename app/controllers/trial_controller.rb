class TrialController < ApplicationController
  layout "trial"
  before_action :authenticate_user!
  
  #Variante A -> Registrieren -> Ort + Veranstaltung -> Pricing -> Code -> Dashboard
  
  def trial_place
    @user = current_user
    @new_place = Place.new
  end
  
  def create_trial_place
    @user = current_user
    @new_place = Place.new(place_params)
    @new_place.formatted_address = params[:formatted_address]
    @new_place.route = params[:route]
    @new_place.street_number = params[:street_number]
    @new_place.postal_code = params[:postal_code]
    @new_place.locality = params[:locality]
    @new_place.place_id = params[:place_id]
    @new_place.lat = params[:lat]
    @new_place.lng = params[:lng]
    @new_place.save
    
    redirect_to trial_event_path
  end
  
  def trial_event
    @user = current_user
    @new_event = Event.new
  end
  
  def trial_pricing
    
  end
  
  def trial_code
  
  end
  
  def trial_payment
    
  end
  
  private
  
  def place_params
    params.require(:place).permit(:user_id, :name, :type, :formatted_address, :route, :street_number, :postal_code, :locality, :place_id, :lat, :lng)
  end
  
end
