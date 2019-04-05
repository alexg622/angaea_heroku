class Activity < ApplicationRecord
 belongs_to :user
 has_many :ratings, dependent: :delete_all
 has_many :tags, dependent: :delete_all
 has_many_attached :images
 has_one_attached :image

 has_many :booking_venues

 has_many :venues,
  through: :booking_venues,
  source: :venue

 has_many :activity_tickets, dependent: :delete_all

has_one :chatroom

has_many :messages,
  through: :chatroom,
  source: :chatroom

 has_many :attendees,
  through: :activity_tickets,
  source: :user

 has_many :categories,
   through: :tags,
   source: :category
 #has many attributes
 validates :user_id, :contact_email, :additional_info, :start_date, :end_date, :activity_name, :cost, :city, :capacity, :addressLN1, :state, :zip, :content, presence: true
 validates :content, presence: true, length: { minimum: 1 }

 # mount_uploader :picture, PictureUploader
 default_scope -> { order(created_at: :desc) }
 # get average rating
 def get_average_rating
   average = 0
   if self.ratings.any?
     self.ratings.each {|rating| average += rating.stars}
     return (average/self.ratings.length).round
   end
   return 0
 end
 # get highest rated comments
 def get_comment
   comment = nil
   self.ratings.each do |rating|
     if rating.stars == 5
       comment = rating.comment.split(".")[0]
     end
   end
   if comment == nil
     self.ratings.each do |rating|
       if rating.stars == 4
         comment = rating.comment.split(".")[0]
       end
     end
   end
   if comment == nil
     self.ratings.each do |rating|
       if rating.stars == 3
         comment = rating.comment.split(".")[0]
       end
     end
   end
   if comment == nil
     self.ratings.each do |rating|
       if rating.stars == 2
         comment = rating.comment.split(".")[0]
       end
     end
   end
   if comment == nil
     self.ratings.each do |rating|
       if rating.stars == 1
         comment = rating.comment.split(".")[0]
       end
     end
   end
   if comment == nil
     comment =""
   end
   return comment
 end
 # categorize activities by category
 def self.categorize_activities
   categories_hash = {
     "dance" => [],
     "music" => [],
     "art" => [],
     "theatre" => [],
     "comedy" => [],
     "food" => [],
     "others" => [],
   }

   self.all.each do |activity|
     if activity.categories.any?
       if activity.start_date >= DateTime.now
         categories_hash[activity.categories[0].category_name].push(activity)
       end
     end
   end
   return categories_hash
 end

 def format_start_date
   self.start_date.strftime("%a, %B %d,%l:%M%p")
 end

 def format_end_date
   self.end_date.strftime("%a, %B %d,%l:%M%p")
 end

 def show_end_day
   self.end_date.strftime("%a, %B %d")
 end

 def show_start_day
   self.start_date.strftime("%a, %B %d")
 end

 def show_end_time
   self.end_date.strftime("%l:%M%p")
 end

 def show_start_time
   self.start_date.strftime("%l:%M%p")
 end

 def show_full_start_day
   days = {
     "Mon" => "Monday",
     "Tue" => "Tuesday",
     "Wed" => "Wednesday",
     "Thu" => "Thursday",
     "Fri" => "Friday",
     "Sat" => "Saturday",
     "Sun" => "Sunday",
   }
   return days[self.start_date.strftime("%a")]
 end

 def show_full_end_day
   days = {
     "Mon" => "Monday",
     "Tue" => "Tuesday",
     "Wed" => "Wednesday",
     "Thu" => "Thursday",
     "Fri" => "Friday",
     "Sat" => "Saturday",
     "Sun" => "Sunday",
   }
   return days[self.end_date.strftime("%a")]
 end

 def show_recurring_weekly
   if self.show_full_start_day == self.show_full_end_day
     return self.show_full_start_day
   else
     return self.show_full_start_day + " - " + self.show_full_end_day
   end
 end


 def format_location
   address_one = self.addressLN1
   address_two = self.addressLN2 ? " " + self.addressLN2 + "," : ""
   city = self.city
   state = self.state
   zip = self.zip
   "#{city}, #{state} #{zip}"
 end

 def format_full_location
   address_one = self.addressLN1
   address_two = ""
   if self.addressLN2 != nil
     address_two = self.addressLN2 != "" ? " " + self.addressLN2 + "," : ""
   end
   city = self.city
   state = self.state
   zip = self.zip
   "#{address_one},#{address_two} #{city}, #{state} #{zip}"
 end

 def Activity.show_prices
   prices = []
   Activity.all.each do |activity|
     prices.push(activity.activity_name + ": " + activity.cost)
   end
   prices
 end

 def format_activity_name
   self.activity_name[-1] == "." ? self.activity_name[0...self.activity_name.length-1] : self.activity_name
 end

 def email_attendees
   email = "https://mail.google.com/mail/u/0/?view=cm&fs=1&tf=1&bcc="
   if self.attendees.length > 0
     i=0
     while i < self.attendees.length
       if i === self.attendees.length-1
         email += self.attendees[i].email
       else
         email += self.attendees[i].email + "%20"
       end
       i += 1
     end
   end
   return email
 end

 def is_attending
   attendees = {}
   self.attendees.each do |attendee|
     attendees[attendee.id] = true
   end
   return attendees
 end

end
