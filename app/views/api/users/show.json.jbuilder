json.currentUser do
  json.extract! @user, :name, :email, :id, :profession, :skills, :about, :facebook,
  :instagram, :youtube, :pinterest, :twitter, :agree_to_terms, :agree_to_privacy,
  :routing_number, :account_number, :city, :state, :zipcode, :address, :account_activated,
  :email_list
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
