class ApplicationMailer < ActionMailer::Base
  default from: 'do-not-reply@the-radr.com'
  layout 'mailer'
  
  class UserMailer < ApplicationMailer
  end
  
end
