class Rating < ApplicationRecord

  belongs_to :user
  belongs_to :activity

  validates :stars, presence: true
end
