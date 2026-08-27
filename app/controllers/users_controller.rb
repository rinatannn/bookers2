class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :update, :followings, :followers]
  before_action :is_matching_login_user, only: [:edit, :update]

  def sessions
    render :sessions
  end

  def registrations
    @user = User.new
    render :registrations
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user),
                  notice: "Welcome! You have signed up successfully."
    else
      render :registrations
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user.id),
                  notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :email_address,
      :password,
      :password_confirmation,
      :introduction,
      :profile_image
    )
  end

  def is_matching_login_user
    user = User.find(params[:id])

    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end