class Rental < ApplicationRecord
  belongs_to :user
  has_many :rental_ratings, dependent: :delete_all
  has_many :rental_tickets, dependent: :delete_all
  has_one_attached :image
  has_many :renters,
    through: :rental_tickets,
    source: :user

  validates :cost, :contact_email, :start_date, :end_date, :rental_name, :description, :addressLN1, :state, :city, :zipcode, presence: true



  def format_start_date
    self.start_date.strftime("%a, %B %d,%l:%M%p")
  end

  def format_end_date
    self.end_date.strftime("%a, %B %d,%l:%M%p")
  end

  def format_location
    address_one = self.addressLN1
    address_two = self.addressLN2 ? " " + self.addressLN2 + "," : ""
    city = self.city
    state = self.state
    zip = self.zipcode
    "#{address_one},#{address_two} #{city}, #{state} #{zip}"
  end

  def format_rental_name
    self.rental_name[-1] == "." ? self.rental_name[0...self.rental_name.length-1] : self.rental_name
  end

  def get_average_rating
    average = 0
    if self.rental_ratings.any?
      self.rental_ratings.each {|rating| average += rating.stars.to_i}
      return (average/self.rental_ratings.length).round
    end
    return 0
  end
  # get highest rated comments
  def get_comment
    comment = nil
    self.rental_ratings.each do |rating|
      if rating.stars == 5
        comment = rating.comment.split(".")[0]
      end
    end
    if comment == nil
      self.rental_ratings.each do |rating|
        if rating.stars == 4
          comment = rating.comment.split(".")[0]
        end
      end
    end
    if comment == nil
      self.rental_ratings.each do |rating|
        if rating.stars == 3
          comment = rating.comment.split(".")[0]
        end
      end
    end
    if comment == nil
      self.rental_ratings.each do |rating|
        if rating.stars == 2
          comment = rating.comment.split(".")[0]
        end
      end
    end
    if comment == nil
      self.rental_ratings.each do |rating|
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


end
