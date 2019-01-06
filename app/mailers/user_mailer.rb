class UserMailer < ApplicationMailer
  default from: 'do-not-reply@the-radr.com'
 
  def welcome_email
    @user = params[:user]
    @url  = 'https://app.the-radr.com'
    mail(to: @user.email, subject: 'Willkommen bei Radr')
  end
  
end