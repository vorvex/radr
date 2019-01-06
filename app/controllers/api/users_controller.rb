class Api::UsersController < ApplicationController
  before_action :set_location
  
  def show
  end
  
  private
  
  def set_location
    @user = User.find(params[:id])
  end
  
end