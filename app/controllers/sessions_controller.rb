class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Welcome! You have signed in successfully."
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed out successfully."
  end
end
