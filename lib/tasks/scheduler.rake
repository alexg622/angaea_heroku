task :update_recurring_weekly_activities => :environment do

  # 17 Jan 2019 20:00:51 UTC +00:00
  def create_new_date(date_of_activity)
    days = {
      "1" =>  "Mon",
      "2" =>  "Tue",
      "3" =>  "Wed",
      "4" =>  "Thu",
      "5" =>  "Fri",
      "6" =>  "Sat",
      "7" =>  "Sun"
    }

    months = {
      "1"  =>  "Jan",
      "2"  =>  "Feb",
      "3"  =>  "Mar",
      "4"  =>  "Apr",
      "5"  =>  "May",
      "6"  =>  "Jun",
      "7"  =>  "Jul",
      "8"  =>  "Aug",
      "9"  =>  "Sep",
      "10" =>  "Oct",
      "11" =>  "Nov",
      "12" =>  "Dec"
    }

    days_in_month = {
      "Jan" => "31",
      "Feb" => "28",
      "Mar" => "31",
      "Apr" => "30",
      "May" => "31",
      "Jun" => "30",
      "Jul" => "31",
      "Aug" => "31",
      "Sep" => "30",
      "Oct" => "31",
      "Nov" => "30",
      "Dec" => "31"
    }

    activityDateNumber = date_of_activity.strftime("%d").to_i + 7
    year = date_of_activity.strftime("%Y")
    monthWords = date_of_activity.strftime("%b")
    monthNumber = date_of_activity.strftime("%m").to_i
    dayOfWeek = date_of_activity.strftime("%a")
    startTime = date_of_activity.strftime("%H") + ":" + date_of_activity.strftime("%M") + ":" + "00 " + "UTC " + "+00:00"
    if activityDateNumber > days_in_month[monthWords].to_i
      activityDateNumber = activityDateNumber - days_in_month[monthWords].to_i
      monthNumber += 1
      monthWords = months[monthNumber.to_s]
      if monthNumber > 12
        monthNumber = 1
        monthWords = months[monthNumber.to_s]
        year = (year.to_i + 1).to_s
      end
    end
    new_start_time = "#{activityDateNumber.to_s} #{monthWords} #{year} #{startTime}"
  end

  weekly_activities_to_update = []

  Activity.all.each do |activity|
    todays_date = DateTime.now
    if activity.recurring_schedule == "weekly" && activity.start_date < todays_date
      weekly_activities_to_update.push(activity)
    end
  end

  weekly_activities_to_update.each do |activity|
    new_start_date = create_new_date(activity.clone.start_date)
    new_end_date = create_new_date(activity.clone.end_date)

    new_activity = Activity.create(start_date: new_start_date, end_date: new_end_date, user_id: activity.user.id, recurring_schedule: activity.recurring_schedule, image: activity.image, capacity: activity.capacity, contact_email: activity.contact_email, contact_number: activity.contact_number, activity_name: activity.activity_name, content: activity.content, additional_info: activity.additional_info, cost: activity.cost, addressLN1: activity.addressLN1, addressLN2: activity.addressLN2, city: activity.city, state: activity.state, zip: activity.zip)
    Chatroom.create(activity_id: new_activity.id, topic: new_activity.activity_name)
    Tag.create(activity_id: new_activity.id, category_id: activity.categories[0].id)

    if activity.image.attached?
      new_activity.image.attach(activity.image.blob)
    end
    if activity.images.attached?
      activity.images.each do |image|
        new_activity.images.attach(image.blob)
      end
    end
    activity.update_attributes(recurring_schedule: "")
  end
end

task :update_recurring_bi_weekly_activities => :environment do

  # 17 Jan 2019 20:00:51 UTC +00:00
  def create_new_date(date_of_activity)
    days = {
      "1" =>  "Mon",
      "2" =>  "Tue",
      "3" =>  "Wed",
      "4" =>  "Thu",
      "5" =>  "Fri",
      "6" =>  "Sat",
      "7" =>  "Sun"
    }
    months = {
      "1"  =>  "Jan",
      "2"  =>  "Feb",
      "3"  =>  "Mar",
      "4"  =>  "Apr",
      "5"  =>  "May",
      "6"  =>  "Jun",
      "7"  =>  "Jul",
      "8"  =>  "Aug",
      "9"  =>  "Sep",
      "10" =>  "Oct",
      "11" =>  "Nov",
      "12" =>  "Dec"
    }

    days_in_month = {
      "Jan" => "31",
      "Feb" => "28",
      "Mar" => "31",
      "Apr" => "30",
      "May" => "31",
      "Jun" => "30",
      "Jul" => "31",
      "Aug" => "31",
      "Sep" => "30",
      "Oct" => "31",
      "Nov" => "30",
      "Dec" => "31"
    }

    activityDateNumber = date_of_activity.strftime("%d").to_i + 14
    year = date_of_activity.strftime("%Y")
    monthWords = date_of_activity.strftime("%b")
    monthNumber = date_of_activity.strftime("%m").to_i
    dayOfWeek = date_of_activity.strftime("%a")
    startTime = date_of_activity.strftime("%H") + ":" + date_of_activity.strftime("%M") + ":" + "00 " + "UTC " + "+00:00"
    if activityDateNumber > days_in_month[monthWords].to_i
      activityDateNumber = activityDateNumber - days_in_month[monthWords].to_i
      monthNumber += 1
      monthWords = months[monthNumber.to_s]
      if monthNumber > 12
        monthNumber = 1
        monthWords = months[monthNumber.to_s]
        year = (year.to_i + 1).to_s
      end
    end
    new_start_time = "#{activityDateNumber.to_s} #{monthWords} #{year} #{startTime}"
  end

  bi_weekly_activities_to_update = []

  Activity.all.each do |activity|
    todays_date = DateTime.now
    if activity.recurring_schedule == "bi-weekly" && activity.start_date < todays_date
      bi_weekly_activities_to_update.push(activity)
    end
  end

  bi_weekly_activities_to_update.each do |activity|
    new_start_date = create_new_date(activity.clone.start_date)
    new_end_date = create_new_date(activity.clone.end_date)

    new_activity = Activity.create(start_date: new_start_date, end_date: new_end_date, user_id: activity.user.id, recurring_schedule: activity.recurring_schedule, image: activity.image, capacity: activity.capacity, contact_email: activity.contact_email, contact_number: activity.contact_number, activity_name: activity.activity_name, content: activity.content, additional_info: activity.additional_info, cost: activity.cost, addressLN1: activity.addressLN1, addressLN2: activity.addressLN2, city: activity.city, state: activity.state, zip: activity.zip)
    Chatroom.create(activity_id: new_activity.id, topic: new_activity.activity_name)
    Tag.create(activity_id: new_activity.id, category_id: activity.categories[0].id)

    if activity.image.attached?
      new_activity.image.attach(activity.image.blob)
    end
    if activity.images.attached?
      activity.images.each do |image|
        new_activity.images.attach(image.blob)
      end
    end
    activity.update_attributes(recurring_schedule: "")
  end
end
