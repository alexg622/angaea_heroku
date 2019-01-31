# namespace :my_namespace do
#   desc "TODO"
#   task send_activity_email: :environment do
#     AngaeaActivationMailer.test_scheduler(User.find(15)).deliver
#   end
# end

task :create_test do
  User.create(name: "test it out okay", email: "testitoutokay@maily.com", password: "password")
end
