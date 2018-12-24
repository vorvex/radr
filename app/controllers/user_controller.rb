class UserController < ApplicationController

  def update
    @user = User.find(1)
    @user.website = params[:user][:website]
    @user.save
    redirect_to root_path
  end

end