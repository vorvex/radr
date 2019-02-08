class ApplicationController < ActionController::Base
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?
  helper_method :create_bill, :create_charge

    def json_request?
      request.format.js?
    end
  
    def create_bill(amount)
      @user = current_user
      @client = Airtable::Client.new("keyEjrVtXi3R10TJe")
      @table = @client.table("appUc27X5NKBKsHrT", "rechnungen")
      
      name = @user.billing_address.firstname + " " + @user.billing_address.lastname
      amount += 0.0 
      amount /= 100
      
      @record = Airtable::Record.new(
                                     :name => name, 
                                     :kunden_id => @user.id, 
                                     :street => @user.billing_address.street, 
                                     :plz => @user.billing_address.plz, 
                                     :locality => @user.billing_address.locality,
                                     :country => @user.billing_address.country,
                                     :amount => amount)
      @table.create(@record)
    end
  
    def create_charge(amount)
        Stripe.api_key = ENV['stripe_api_key']
        customer = Stripe::Customer.retrieve(current_user.stripe_token)
        description = "Radr Event SEO - " + @new_event.name + " - ID:" + @new_event.id
        charge = Stripe::Charge.create(
        amount: amount,
        currency: "eur",
        description: description,
        receipt_email: @user.email,
        customer: customer.id,
        )
    end
  
    def check_payment
      unless @user.confirmed || @user.trial? 
        customer = Stripe::Customer.retrieve(current_user.stripe_token)
        charge = customer.charges.first
        charge.capture
        if customer.charges.first.status != "failed"
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
