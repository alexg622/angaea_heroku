namespace :my_namespace do
  desc "TODO"
  task send_activity_email: :environment do
    AngaeaActivationMailer.test_scheduler(User.find(15)).deliver
  end
end
