class UserMailer < ApplicationMailer
  default from: "admin@musicapp.com"

  def activation_email(user)
    @user = user
    mail(to: @user.email, subject: "Activate your account")
  end
end
