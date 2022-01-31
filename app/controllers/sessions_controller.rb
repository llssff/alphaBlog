class SessionsController < ApplicationController
  def create
    param_session = params[:session]
    user = User.find_by(email: param_session[:email].downcase)
    if user && user.authenticate(param_session[:password])
      session[:user_id] = user.id
      flash[:notice] = "logged in good"
      redirect_to user
    else
      flash.now[:alert] = "shits bad cuz"
      render 'new'
    end
  end

  def new

  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "logged out"
    redirect_to root_path
  end
end
