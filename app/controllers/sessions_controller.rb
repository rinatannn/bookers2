class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params.dig(:user, :name))

    if user && user.authenticate(params.dig(:user, :password))
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Welcome! You have signed in successfully."
    else
      flash.now[:alert] = "Invalid name or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed out successfully."
  end
end