task :create_test do
  User.create(name: "test it out okay", email: "testitoutokay@maily.com", password: "password")
end
