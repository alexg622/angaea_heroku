class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_save :downcase_email
  has_one :stripe_connect
  before_create :create_activation_digest
  has_many :activities, dependent: :delete_all
  has_many :cards, dependent: :delete_all
  has_one_attached :image
  has_many :read_messages
  has_many :services, dependent: :delete_all
  has_many :messages
  has_many :user_messages
  has_many :connect_users
  has_many :user_chatrooms,
    through: :connect_users,
    source: :user_chatroom

  # has_many :appointments, dependent: :delete_all
  has_many :appointments,
    through: :services,
    source: :appointments

  has_many :chatrooms, through: :messages
  has_many :appointment_tickets, dependent: :delete_all
  has_many :upcoming_appointments,
    through: :appointment_tickets,
    source: :appointment
  # def thubmnail
    # exclamation forces resize
    # return self.image.variant(resize: "300x300").processed
    # -----no exclamation
    # return self.image.variant(resize: "300x300!").processed
  # end
  # when has_many_attached :images
  # def thubmnail(input)
    # exclamation forces resize
    # return self.image[input].variant(resize: "300x300").processed
    # no exclamation
    # return self.image[input].variant(resize: "300x300!").processed
  # end
  # link to tutorial https://www.youtube.com/watch?v=A23zCePXe74
  # in view call it - image_tag(@user.thumbnail)
  # need imageMagick and minimagic


  has_many :rental_tickets, dependent: :delete_all
  has_many :rented_items,
    through: :rental_tickets,
    source: :rental

  has_many :activity_tickets, dependent: :delete_all
  has_many :events,
    through: :activity_tickets,
    source: :activity

  has_many :service_tickets, dependent: :delete_all

  has_many :upcoming_services,
    through: :service_tickets,
    source: :service


  has_many :ratings, dependent: :delete_all
  has_many :rental_ratings
  has_many :rentals, dependent: :delete_all

  before_save { email.downcase! }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :city, :state, :zipcode, presence: true

  def unread_messages
    sum = 0
    self.activities.each do |activity|
      sum += activity.chatroom.messages.length
    end
    return sum - self.read_messages.length
  end

  def get_booked(month_number, day_number)
    result = []
    self.appointments.each do |appointment|
      if appointment.start_time.month == month_number && appointment.start_time.day == day_number && appointment.booked == "true"
        result.push(appointment)
      end
    end
    return result.sort_by {|appointment| appointment.start_time}
  end

  def get_not_booked(month_number, day_number)
    result = []
    self.appointments.each do |appointment|
      if appointment.start_time.month == month_number && appointment.start_time.day == day_number && appointment.booked != "true"
        result.push(appointment)
      end
    end
    return result.sort_by {|appointment| appointment.start_time}
  end

  def show_booked_appointments
    result = []
    self.appointments.each do |appointment|
      if appointment.booked == "true"
        result << appointment
      end
    end
    return result
  end

  def show_unbooked_appointments
    result = []
    self.appointments.each do |appointment|
      if appointment.booked != "true"
        result << appointment
      end
    end
    return result
  end

  def show_location
    if self.city != "" && self.state != "" && self.zipcode != "" && self.zipcode != nil && self.city != nil && self.state != nil
      return "#{self.city}, #{self.state}"
    else
      return ""
    end
  end

  def user_events
    events = {}
    events_arr = []
    if self.events.any?
      self.events.each {|event| events[event.id] = event}
    end
    events.each {|key, value| events_arr << value}
    return events_arr
  end

def User.digest(string)
   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                 BCrypt::Engine.cost
   BCrypt::Password.create(string, cost: cost)
 end
 # Returns a random token.

 def User.new_token
   SecureRandom.urlsafe_base64
 end

 # Remembers a user in the database for use in persistent sessions.
 def remember
   self.remember_token = User.new_token
   update_attribute(:remember_digest, User.digest(remember_token))
 end

 def authenticated?(remember_token)
   return false if remember_digest.nil?
   BCrypt::Password.new(remember_digest).is_password?(remember_token)
 end

 def forget
   update_attribute(:remember_digest, nil)
 end

   # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
  end

  private
  def downcase_email
    self.email = email.downcase
  end

  def User.show_emails
    emails = []
    User.all.each do |user|
      emails.push(user.name + ":" + " " + user.email)
    end
    emails
  end

  def User.show_good_emails
    emails = []
    User.all.each do |user|
      if user.email_list == "yes"
        emails.push(user.name + ":" + " " + user.email)
      end
    end
    emails
  end

  def User.show_professions
    emails = []
    User.all.each do |user|
      emails.push(user.name + ":" + " " + user.profession)
    end
    emails
  end

  def User.email_all_users
    i = 0
    email = "https://mail.google.com/mail/u/0/?view=cm&fs=1&tf=1&bcc="
    all_users = User.all
    if all_users.length > 0
      while i < all_users.length
        if all_users[i].email_list == "yes"
          if i == all_users.length-1
            email += all_users[i].email
          else
            email += all_users[i].email + "%20"
          end
        end
        i += 1
      end
    end
    return email
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
