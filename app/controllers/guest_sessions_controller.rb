class GuestSessionsController < ApplicationController
  def create
    user = User.guest
    session[:user_id] = user.id

    redirect_to user_path(user), notice: "guestuserでログインしました。"
  end
end