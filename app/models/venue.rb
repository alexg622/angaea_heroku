class Venue < ApplicationRecord
  belongs_to :user
  has_many :booking_venues
  has_many :experiences,
    through: :booking_venues,
    source: :activity

  validates :venue_name, :capacity, :address, :city, :state, :zip, presence: true
end
