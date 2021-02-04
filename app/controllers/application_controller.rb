class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    user = User.find_by(session_token: session[:session_token])
    return nil unless user
    user
  end

  def login_user!(user)
    token = user.reset_session_token!
    session[:session_token] = token
  end

  def logged_in?
    return true if session[:session_token]
    false
  end
end
