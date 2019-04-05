class BookingVenue < ApplicationRecord
  belongs_to :activity
  belongs_to :venue
  has_one :user,
    through: :activity,
    source: :user

  validates :start_time, :end_time, presence: true
end
