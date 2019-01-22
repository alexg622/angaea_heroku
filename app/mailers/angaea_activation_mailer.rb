class AngaeaActivationMailer < ApplicationMailer
  default from: "contact@angaea.com"

  def send_activation_link(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Angaea!")
  end

  def send_activity_info(user, activity, activity_ticket)
    @activity = activity
    @user = user
    @activity_ticket = activity_ticket
    @spot_num = activity_ticket.spots_buying > 1 ? "spots" : "spot"
    mail(to: @user.email, subject: "You got a spot for #{activity.activity_name}")
  end
end
