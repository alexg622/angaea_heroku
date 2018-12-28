class Tag < ApplicationRecord
  validates :activity_id, uniqueness:  { scope: :category_id }

  belongs_to :activity
  belongs_to :category

end
