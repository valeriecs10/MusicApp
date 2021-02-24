class SessionsController < ApplicationController
  skip_before_action :redirect_unless_logged_in, only: [:new, :create]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if user
      if user.activated
        login_user!(user)
        redirect_to bands_url
      else
        msg= "Account not yet activated"
        flash_message(:alert, msg)
        render :new
      end
    else 
      msg = "Wrong user/password combo"
      flash_message(:alert, msg)
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = ""
    redirect_to new_session_url
  end
end