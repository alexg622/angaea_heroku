# Preview all emails at http://localhost:3000/rails/mailers/angaea_activation_mailer
class AngaeaActivationMailerPreview < ActionMailer::Preview
  def angaea_activation_mailer
    @user = User.all.sample
    AngaeaActivationMailer.send_activation_link(@user)
  end

  def angaea_activation_activity_mailer
    @user = User.first
    @activity_ticket = @user.activity_tickets.sample
    @activity = @user.activities.find(@activity_ticket.activity_id)
    AngaeaActivationMailer.send_activity_info(@user, @activity, @activity_ticket)
  end
end
