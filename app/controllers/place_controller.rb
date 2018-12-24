class PlaceController < ApplicationController
  
  def create
    @user = User.first
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
    
    redirect_to root_path
  end
  
  def destroy
    @place = Place.find(params[:id])
    @place.destroy!
    redirect_to root_path
  end
  
  def edit 
    
  end
  
  private
  
  def place_params
    params.require(:place).permit(:user_id, :name, :type, :formatted_address, :route, :street_number, :postal_code, :locality, :place_id, :lat, :lng)
  end
end