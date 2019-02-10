class UserController < ApplicationController

  def update
    @user = current_user
    @user.website = params[:user][:website]
    @user.save
    redirect_to root_path
  end

  def change
    @user = current_user
    case params[:change]
    when "1" #Löschen
      @user.delete!
      @url = "https://www.the-radr.com"
      redirect_to @url
    when "2" #Typ ändern
      if @user.plan == "premium"
        @user.plan = "keinebindung"
        @user.save!
      elsif @user.plan == "keinebindung"
        @user.plan = "premium"
        create_charge(5000)
        @user.save!
      elsif @user.plan == "keinebindungrechnung"
        @user.plan = "premiumrechnung"
        create_bill(5000)
        @user.save!
      elsif @user.plan == "premiumrechnung"
        @user.plan = "keinebindungrechnung"
        @user.save!
      end
    when "3" #Rechnung
      if @user.plan == "premium" || @user.plan == "keinebindung"
        redirect_to trial_bill_path
      end
    when "4" #Kreditkarte
      
    end
    
  end
  
  
end