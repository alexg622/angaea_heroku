class RentalRating < ApplicationRecord
  belongs_to :user
  belongs_to :rental

  validates :comment, :stars, presence: true 
end
