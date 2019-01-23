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

  def test_scheduler
    @user = User.find(1)
    AngaeaActivationMailer.test_scheduler(@user)
  end

  def post_activation_email
    @user = User.all.sample
    AngaeaActivationMailer.post_activation_email(@user)
  end
end
