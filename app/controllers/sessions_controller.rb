class SessionsController < ApplicationController
  skip_before_action :authorise
  
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to portal_url
    else
      redirect_to login_url, alert: "Invalid user name or password."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, notice: "You've been logged out. See you next time!"
  end
end
