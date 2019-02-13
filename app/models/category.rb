class Category < ApplicationRecord
  validates :category_name, presence: true
  validates :category_name, uniqueness: true

  has_many :tags, dependent: :delete_all

  belongs_to :user

  has_many :activities,
    through: :tags,
    source: :activity

  def Category.sort_categories
    return [Category.find_by(category_name: "dance"), Category.find_by(category_name: "music"), Category.find_by(category_name: "comedy"), Category.find_by(category_name: "theatre"), Category.find_by(category_name: "food"), Category.find_by(category_name: "casual")]
  end

end
