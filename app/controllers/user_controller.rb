class UserController < ApplicationController

  def update
    @user = current_user
    @user.website = params[:user][:website]
    @user.save
    redirect_to root_path
  end

end