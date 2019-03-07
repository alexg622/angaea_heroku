class Service < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_one_attached :image
  has_many :service_tags, dependent: :delete_all
  has_many :categories,
    through: :service_tags,
    source: :category

  has_many :service_tickets, dependent: :delete_all
  has_many :appointments, dependent: :delete_all
  has_many :clients,
    through: :service_tickets,
    source: :user

  validates :zip, :content, :service_name, :city, :state, :contact_number, :contact_email, :cost, :travel_options, :availability_days, :availability_hours, presence: true

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

      self.all.each do |service|
        if service.categories.any?
          if service.start_date >= DateTime.now
            categories_hash[service.categories[0].category_name].push(service)
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
      Activity.all.each do |service|
        prices.push(service.service_name + ": " + service.cost)
      end
      prices
    end

    def format_service_name
      self.service_name[-1] == "." ? self.service_name[0...self.service_name.length-1] : self.service_name
    end

    def email_attendees
      email = "https://mail.google.com/mail/u/0/?view=cm&fs=1&tf=1&bcc="
      if self.clients.length > 0
        i=0
        while i < self.clients.length
          if i === self.clients.length-1
            email += self.clients[i].email
          else
            email += self.clients[i].email + "%20"
          end
          i += 1
        end
      end
      return email
    end

end
