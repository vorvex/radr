class Api::UsersController < ApplicationController
  before_action :set_location
  
  def show
    UserMailer.with(user: @user).welcome_email.deliver_now
  end
  
  private
  
  def set_location
    @user = User.find(params[:id])
  end
  
end