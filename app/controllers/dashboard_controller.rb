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
  
  private
  
  def check_payment
    unless @user.confirmed && @user.trial? 
      customer = Stripe::Customer.retrieve(current_user.stripe_token)
      charge = customer.charges.first
      charge.capture
      if charge.capture
        @user.confirmed = true
      else
        @user.confirmed = false
        @user.plan = "nichtbezahlt"
      end
      @user.save!
    end
  end
  
  def check_plan
    if @user.plan == "nichtbezahlt"
      redirect_to freischalten_path 
    elsif @user.plan == "free"
      redirect_to free_path
    end
  end
  
end
