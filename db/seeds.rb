# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# user1 = User.create(name: "Bill", email: "Bill@mail.com", profession: "Computer Engineer", skills: "CSS, HTML, JavaScript, Python, Ruby, React/Redux", about_me: "this is test data to put on the website in place of the about me section asdlfkjsldkj jfdslk; aflskdj fjdlksa;f lsadkjf lsdkaf jlk;asdjf sdl;akj sdafl;kj sdalkfj dsf", password: "password")
# user2 = User.create(name: "Jill", email: "Jill@mail.com", password: "password")
# user3 = User.create(name: "Joe", email: "Joe@mail.com", password: "password")
# user4 = User.create(name: "Henry", email: "Henry@mail.com", password: "password")
#
# test_rental = Rental.create(contact_email: "test@mail.com", cost: 55, rental_name: "Truck", city: "SF", addressLN1: "131 this street", state: "CA", zipcode: "94132", user_id: user1.id, start_date: user1.created_at, end_date: user1.created_at, description: Faker::Lorem.paragraph(2))
# test_rental2 = Rental.create(contact_email: "test@mail.com", cost: 55, rental_name: "Truck", city: "SF", addressLN1: "131 this street", state: "CA", zipcode: "94132", user_id: user1.id, start_date: user1.created_at, end_date: user1.created_at, description: Faker::Lorem.paragraph(2))
# test_rental3 = Rental.create(contact_email: "test@mail.com", cost: 55, rental_name: "Truck", city: "SF", addressLN1: "131 this street", state: "CA", zipcode: "94132", user_id: user1.id, start_date: user1.created_at, end_date: user1.created_at, description: Faker::Lorem.paragraph(2))
# # test_rental.owner = user3
# # test_rental.renter = user2
#
# 10.times do
#   User.all.each do |user|
#     Rental.create(contact_email: Faker::Internet.email, cost: 55, rental_name: Faker::Name.name, city: "SF", addressLN1: "131 this street", state: "CA", zipcode: "94132", user_id: user.id, start_date: user.created_at, end_date: user.created_at, description: Faker::Lorem.paragraph(2))
#   end
# end
#
# 10.times do |counter|
#  name = Faker::HarryPotter.character
#  User.create!(name: name, skills: Faker::ChuckNorris.fact, profession: Faker::Job.title, email: (name.split(" ")[0]+counter.to_s+"@mail.com"), about_me: Faker::GameOfThrones.quote, password: "password")
# end

# art = Category.create!(category_name: "art", user_id: adminUser.id)
# music = Category.create!(category_name: "music", user_id: adminUser.id)
# dance = Category.create!(category_name: "dance", user_id: adminUser.id)

# categories = [art, music, dance]
#
# 10.times do
#  content = Faker::Lorem.sentence(5)
#  User.all.each do |user|
#    Activity.create!(start_date: "Thu, 20 Dec 2018 18:00:12 UTC +00:00", end_date: "Thu, 20 Dec 2018 18:00:12 UTC +00:00", capacity: "100", contact_email: "Test@mail.com", user_id: user.id, picture: Faker::LoremPixel.image("50x60"), activity_name: Faker::GameOfThrones.quote, content: Faker::Lorem.paragraph(2), cost: rand(500).to_s, city: Faker::Address.city, state: Faker::Address.state, addressLN1: Faker::Address.street_address, zip: Faker::Address.zip)
#    Tag.create(activity_id: user.activities.first.id, category_id: categories[rand(3)].id)
#  end
# end
#
# User.all.each do |user|
#  user.activities.each do |activity|
#    5.times do |i|
#      Rating.create(user_id: user.id, activity_id: activity.id, stars: (i+1), comment: Faker::ChuckNorris.fact)
#    end
#  end
# end
#
# User.all.each do |user|
#   user.rentals.each do |rental|
#     5.times do |i|
#       RentalRating.create(user_id: user.id, rental_id: rental.id, stars: (i+1), comment: Faker::ChuckNorris.fact)
#     end
#   end
# end
#
# User.all.each do |user|
#   8.times do |i|
#     RentalTicket.create(user_id: user.id, rental_id: Rental.all[i].id)
#   end
# end
#
# User.all.each do |user|
#   8.times do |i|
#     ActivityTicket.create(user_id: user.id, activity_id: Activity.all[i].id)
#   end
# end
