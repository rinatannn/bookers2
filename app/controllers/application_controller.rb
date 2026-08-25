class ApplicationController < ActionController::Base
  helper_method :current_user, :user_signed_in?

  def current_user
    @current_user ||= begin
      if Current.session&.user
        Current.session.user
      elsif cookies.signed[:session_id]
        Session.find_by(id: cookies.signed[:session_id])&.user
      elsif session[:user_id]
        User.find_by(id: session[:user_id])
      end
    end
  end

  def user_signed_in?
    current_user.present?
  end

  def authenticate_user!
    unless user_signed_in?
      redirect_to new_session_path
    end
  end
end