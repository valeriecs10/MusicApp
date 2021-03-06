class ApplicationController < ActionController::Base
  helper_method :current_user, :redirect_unless_logged_in, :flash_message
  before_action :redirect_unless_logged_in

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

  def redirect_unless_logged_in
    unless current_user
      redirect_to new_session_url
    end
  end

  def flash_message(type, msg)
    flash[type] ||= []
    flash[type] << msg
  end
end
