class UsersController < ApplicationController
  def new
    render :new
  end

  def create
    new_user = User.new(user_params)
    if new_user.save
      login_user!(user)
      redirect_to user_url(user)
    else 
      render :new
    end
  end

  def show
    user = User.find_by(id: params[:id])
    render json: user.email
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end