# Preview all emails at http://localhost:3000/rails/mailers/angaea_activation_mailer
class AngaeaActivationMailerPreview < ActionMailer::Preview
  def anaea_activation_mailer
    @user = User.all.sample
    AngaeaActivationMailer.send_activation_link(@user)
  end
end
