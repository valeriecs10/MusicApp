class UsersController < ApplicationController
  skip_before_action :redirect_unless_logged_in, only: [:new, :create, :activate]
  def new
    render :new
  end

  def create
    new_user = User.new(user_params)
    if new_user.save
      email = UserMailer.activation_email(new_user)
      email.deliver
      message = "Please activate your account by clicking the link in the email so you can enjoy MusicApp!"
      flash_message(:notice, message)
      redirect_to bands_url
    else 
      new_user.errors.full_messages.each do |msg|
        flash_message(:alert, msg)
      end
      render :new
    end
  end

  def show
    user = User.find_by(id: params[:id])
    render json: user.email
  end

  def activate
    @user = User.find_by(activation_token: params[:activation_token])
    unless @user.activated
      @user.toggle(:activated) 
      @user.save
    end
    message = "Your account has been activated. Please log in now"
    flash_message(:notice, message)
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end