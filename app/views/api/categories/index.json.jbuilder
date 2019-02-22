
json.array! @categories do |category|
   json.category_name category.category_name
   json.id category.id
   json.user_id category.user_id
   json.activities(category.sort_valid_activities) do |activity|
     json.activity_name activity.activity_name
   end
end
