json.currentUser do
  json.extract! @user, :name, :email, :id, :profession, :skills, :about, :facebook,
  :instagram, :youtube, :pinterest, :twitter, :agree_to_terms, :agree_to_privacy,
  :routing_number, :account_number, :city, :state, :zipcode, :address, :account_activated,
  :email_list
  json.showLocation @user.show_location
  json.imageAttached @user.image.attached?
  if @user.image.attached?
    json.imageUrl "http://localhost:3001" + url_for(@user.image)
    json.imageReal @user.image
  end
  json.activities(@user.activities) do |activity|
    json.user do
      json.name activity.user.name
      json.id activity.user.id
    end
    json.activity_name activity.activity_name
    json.content activity.content
    json.additional_info activity.additional_info
    json.cost activity.cost
    json.id activity.id
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
      json.imageUrl "http://localhost:3001" + url_for(activity.image)
      json.imageReal activity.image
    end
  end
  json.upcoming_activities(@user.user_events) do |activity|
    json.user do
      json.name activity.user.name
      json.id activity.user.id
    end
    json.activity_name activity.activity_name
    json.content activity.content
    json.additional_info activity.additional_info
    json.cost activity.cost
    json.id activity.id
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
      json.imageUrl "http://localhost:3001" + url_for(activity.image)
      json.imageReal activity.image
    end
  end
end

# if @jwt
#   json.token do
#     json.jwt @jwt
#   end
# end

# if @event_tickets
#   json.event_tickets do
#     @event_tickets.each do |event_ticket|
#       json.set! event_ticket.id do
#         json.extract! event_ticket, :id, :state, :title, :img_url, :start_time,
#         :end_time, :address, :city, :zipcode, :price, :details,
#         :user_id
#       end
#     end
#   end
# end
