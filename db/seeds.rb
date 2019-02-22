# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user1 = User.create(name: "Angaea", email: "contact@angaea.com", profession: "Computer Engineer", skills: "CSS, HTML, JavaScript, Python, Ruby, React/Redux", about_me: "Making connections", password: "angaea2018!")
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
#  User.create(name: name, skills: Faker::ChuckNorris.fact, profession: Faker::Job.title, email: (name.split(" ")[0]+counter.to_s+"@mail.com"), about_me: Faker::GameOfThrones.quote, password: "password")
# end

art = Category.create(category_name: "art", user_id: User.first.id)
music = Category.create(category_name: "music", user_id: User.first.id)
dance = Category.create(category_name: "dance", user_id: User.first.id)
theatre = Category.create(category_name: "theatre", user_id: User.first.id)
food = Category.create(category_name: "food", user_id: User.first.id)
others = Category.create(category_name: "others", user_id: User.first.id)
comedy = Category.create(category_name: "comedy", user_id: User.first.id)
# categories = [art, music, dance]
#
newService = Service.create!(content: "really cool", service_name: "First service", additional_info: "more info", user_id: User.first.id, cost: "1000", addressLN1: "131 Lake Merced Hills", city: "SF", state: "CA", zip: "94132", capacity: "100", contact_number: "415-909-0164", contact_email: "mail@mail.com", start_date: DateTime.now, end_date: DateTime.now, recurring_schedule: "weekly", travel_options: "both", availability_days: "Every Day", availability_hours: "9-10am")
serviceTag = ServiceTag.create(service_id: newService.id, category_id: art.id)
serviceTicket = ServiceTicket.create(user_id: User.first.id, service_id: newService.id, service_time: DateTime.now, day: "Mon", time: "9:00PM")
# 10.times do
#  content = Faker::Lorem.sentence(5)
#  User.all.each do |user|
#    Activity.create(start_date: "Thu, 20 Dec 2018 18:00:12 UTC +00:00", end_date: "Thu, 20 Dec 2018 18:00:12 UTC +00:00", capacity: "100", contact_email: "Test@mail.com", user_id: user.id, picture: Faker::LoremPixel.image("50x60"), activity_name: Faker::GameOfThrones.quote, content: Faker::Lorem.paragraph(2), cost: rand(500).to_s, city: Faker::Address.city, state: Faker::Address.state, addressLN1: Faker::Address.street_address, zip: Faker::Address.zip)
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
