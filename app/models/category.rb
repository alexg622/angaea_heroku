class Category < ApplicationRecord
  validates :category_name, presence: true
  validates :category_name, uniqueness: true

  has_many :tags, dependent: :delete_all
  has_many :service_tags, dependent: :delete_all

  has_many :services,
    through: :service_tags,
    source: :service

  belongs_to :user

  has_many :activities,
    through: :tags,
    source: :activity

  def Category.sort_categories
    return [Category.find_by(category_name: "dance"), Category.find_by(category_name: "music"), Category.find_by(category_name: "comedy"), Category.find_by(category_name: "theatre"), Category.find_by(category_name: "food"), Category.find_by(category_name: "casual"), Category.find_by(category_name: "art")]
  end

  def activities_not_passed_date
    activities_not_overdate = []
    if self.activities.length > 0
      self.activities.each do |activity|
        if activity.start_date >= DateTime.now
          activities_not_overdate.push(activity)
        end
      end
    end
    return activities_not_overdate
  end

  def sort_valid_activities
    the_activities = self.activities_not_passed_date
    not_sorted = true
    while not_sorted
      not_sorted = false
      for i in 0...the_activities.length-1
        if the_activities[i].start_date > the_activities[i+1].start_date
          the_activities[i], the_activities[i+1] = the_activities[i+1], the_activities[i]
          not_sorted = true
        end
      end
    end
    return the_activities
  end

end
