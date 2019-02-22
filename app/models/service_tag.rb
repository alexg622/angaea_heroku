class ServiceTag < ApplicationRecord
  validates :service_id, uniqueness:  { scope: :category_id }

  belongs_to :service
  belongs_to :category
end
