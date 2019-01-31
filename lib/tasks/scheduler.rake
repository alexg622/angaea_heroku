task :send_reminders => :environment do
  User.create(name: "test it out okay", email: "testitoutokay@maily.com", password: "password")
end
