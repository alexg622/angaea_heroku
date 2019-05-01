json.category do
  json.extract! @category, :category_name, :id, :user_id
  json.activities(@category.sort_valid_activities) do |activity|
    json.activity_name activity.activity_name
    json.content activity.content
    json.additional_info activity.additional_info
    json.cost activity.cost
    json.id activity.id
    json.user do
      json.name activity.user.name
      json.id activity.user.id
    end
    json.addressLN1 activity.addressLN1
    json.addressLN2 activity.addressLN2
    json.city activity.city
    json.formatStartDate activity.format_start_date
    json.formatEndDate activity.format_end_date
    json.showEndDay activity.show_end_day
    json.showStartDay activity.show_start_day
    json.showEndTime activity.show_end_time
    json.showStartTime activity.show_start_time
    json.showFullStartDay activity.show_full_start_day
    json.showFullEndDay activity.show_full_end_day
    json.showRecurringWeekly activity.show_recurring_weekly
    json.formatFullLocation activity.format_full_location
    json.formatActivityName activity.format_activity_name
    json.emailAttendees activity.email_attendees
    json.formatLocation activity.format_location
    json.zip activity.zip
    json.capacity activity.capacity
    json.contact_number activity.contact_number
    json.contact_email activity.contact_email
    json.start_date activity.start_date
    json.end_date activity.end_date
    json.imageAttached activity.image.attached?
    json.imagesAttached activity.images.attached?
    if activity.image.attached?
      json.imageUrl "https://www.angaea.com" + url_for(activity.image)
    end
    if activity.images.attached?
      json.images(0...activity.images.length) do |num|
        json.imageUrl "https://www.angaea.com" + url_for(activity.images[num])
      end
    end
  end
end
