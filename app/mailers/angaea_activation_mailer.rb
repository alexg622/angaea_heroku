class AngaeaActivationMailer < ApplicationMailer
  default from: "alex.gm62288@gmail.com"

  def send_activation_link(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Angaea!")
  end
end
