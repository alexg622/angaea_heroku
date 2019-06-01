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
    mail(to: @user.email, subject: "You are good to go!")
  end

  def send_api_activity_info(activity, spots, email)
    @activity = activity
    @spots = spots
    @spot_num = spots.to_i > 1 ? "spots" : "spot"
    mail(to: email, subject: "You are good to go!")
  end

  def send_service_info(user, service, service_ticket)
    @service = service
    @user = user
    @service_ticket = service_ticket
    mail(to: @user.email, subject: "You are good to go!")
  end

  def test_scheduler(user)
    @user = user
    mail(to: @user.email, subject: "Test Email for Scheduler Angaea Team")
  end

  def post_activation_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Angaea!")
  end

  def send_rental_purchase_email(user, rental, rental_ticket)
    @user = user
    @rental = rental
    @rental_ticket = rental_ticket
    mail(to: @user.email, subject: "You've got it!")
  end

  def send_reset_password_link(user)
    @user = user
    mail(to: @user.email, subject: "Angaea Reset Password Link")
  end

  def send_contact_email_to_ron(user_email, content) 
    @user_email = user_email
    @content = content
    mail(to: "alex.gm62288@gmail.com", subject: "New Question!")
  end

end
