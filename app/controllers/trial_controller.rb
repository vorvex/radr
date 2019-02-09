class TrialController < ApplicationController
  layout "trial"
  before_action :authenticate_user!
  
  #Variante A -> Registrieren -> Ort + Veranstaltung -> Pricing -> Code -> Dashboard
  
  def trial_place
    @user = current_user
    if @user.event_count != 0
      if @user.stripe_token.nil?
        redirect_to trial_payment_path
      else
        redirect_to dashboard_path
      end
    end    
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
    if @user.event_count != 0
      if @user.stripe_token.nil?
        redirect_to trial_payment_path
      else
        redirect_to root_path
      end
    end    
    @new_event = Event.new
  end
  
  def create_trial_event
    @user = current_user   
    @new_event = Event.new(event_params)
    startTime = params[:event][:start_date] + " " + params[:event][:start_time]
    endTime = params[:event][:end_date] + " " + params[:event][:end_time]
    Time.zone = "Berlin"
    @new_event.start_time = Time.zone.strptime(startTime, "%m/%d/%Y %H:%M")
    if @new_event.end_time != nil
      @new_event.end_time = Time.zone.strptime(endTime, "%m/%d/%Y %H:%M")
    end
    if @new_event.save
      @user.event_count += 1
      @user.save!
    else
      redirect_to trial_event_path
    end
    
    redirect_to trial_payment_path
    
  end
  
  def trial_payment
    @user = current_user
  end
  
  def create_trial_payment
    @user = current_user
    token = params[:stripeToken]
    @user.plan = params[:plan]
    email = @user.email
    description = "Radr Event Seo - " + email
    
    Stripe.api_key = ENV['stripe_api_key']
    
    customer = Stripe::Customer.create(
      :email => email,
      :source => token
    )
    
    @user.stripe_token = customer.id
    
    if params[:plan] == "premium"
      charge = Stripe::Charge.create(
      amount: 5000,
      currency: "eur",
      description: description,
      receipt_email: email,
      customer: customer.id,
      capture: false
      )
    elsif @user.plan == "keinebindung"
      @user.confirmed = true
    end
    @user.paid_at = DateTime.now
    @user.save!
    
    redirect_to trial_code_path
    
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      puts e.message
      redirect_to trial_payment_path
  end
  
  def trial_bill
    @user = current_user
    @billing_address = BillingAddress.new
  end

  def create_trial_bill
    @user = current_user
    @user.plan = params[:plan]
    @billing_address = BillingAddress.new(billing_address_params)
    @billing_address.save!
      if @user.plan == "premium"
        @user.plan = "premiumrechnung"
        @user.confirmed = true
        @user.save!
        @client = Airtable::Client.new("keyEjrVtXi3R10TJe")
        @table = @client.table("appUc27X5NKBKsHrT", "rechnungen")

        name = @billing_address.firstname + " " + @billing_address.lastname

        @record = Airtable::Record.new(:name => name, 
                                       :kunden_id => @user.id, 
                                       :street => @billing_address.street, 
                                       :plz => @billing_address.plz, 
                                       :locality => @billing_address.locality,
                                       :country => @billing_address.country,
                                       :amount => 50)
        @table.create(@record)
      elsif @user.plan == "keinebindung"
        @user.plan = "keinebindungrechnung"
        @user.confirmed = true
        @user.save!
      end   
    
    redirect_to trial_code_path
    
  end  
    
  def trial_code
   @user = current_user
   @url = 'https://www.the-radr.com/code-einbinden?id=' + @user.id.to_s
   redirect_to @url
  end
  
  def trial_free
    @code = false
    @event = Event.new
  end
  
  def trial_free_code
    @code = true
    @event = Event.new
    @name = params[:name]
    @start_date = params[:start_date] + "T" + params[:start_time] + "-01:00"
    @end_date = params[:end_date] + "T" + params[:end_time] + "-01:00"
    @place_name = params[:place_name]
    @place_address = params[:place_address]
    @place_locality = params[:place_locality]
    @place_plz = params[:place_plz]
    @image = params[:image]
    @description = params[:description]
    @ticket_url = params[:ticket_url]
    @ticket_price = params[:ticket_price]
    @ticket_status = params[:ticket_status]
    @performer_type = params[:performer_type]
    @performer_name = params[:performer_name]
    
    render :trial_free

  end
  
  def freischalten
    
  end
  
  private
  
  def place_params
    params.require(:place).permit(:user_id, :name, :type, :formatted_address, :route, :street_number, :postal_code, :locality, :place_id, :lat, :lng)
  end
  
  def event_params
    params.require(:event).permit(:name, :description, :user_id, :place_id, :start_time, :end_time, :offer, :price, :ticket_url, :ticket_status, :pathname, :image_url, :start_date, :end_date, :performer_type, :performer ,:image)
  end
  
  def billing_address_params
    params.require(:billing_address).permit(:firstname, :lastname, :street, :plz, :locality, :country, :user_id)
  end
  
end
