class ApplicationController < ActionController::Base
  helper_method :signed_in?, :current_user
  skip_before_action :verify_authenticity_token


  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def signed_in?
    !!current_user
  end

  def sign_in!(user)
    session[:session_token] = user.reset_session_token!
  end

  def ensure_signed_in!
    redirect_to new_session_url unless signed_in?
  end
  
end
