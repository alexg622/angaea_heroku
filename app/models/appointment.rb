class Appointment < ApplicationRecord
  belongs_to :service
  has_many :appointment_tickets, dependent: :delete_all
  has_many :clients,
    through: :appointment_tickets,
    source: :user

  def Appointment.create_appointments(the_service_id, start_time, end_time, day_number, month_number)
    months = {
      "0" => "Jan",
      "1" => "Feb",
      "2" => "Mar",
      "3" => "Apr",
      "4" => "May",
      "5" => "Jun",
      "6" => "Jul",
      "7" => "Aug",
      "8" => "Sep",
      "9" => "Oct",
      "10" => "Nov",
      "11" => "Dec"
    }
    p "montsa;lkfdjasl;dkfj"
    p the_service_id
    appointments_to_create = Appointment.create_times(start_time, end_time)
    if day_number.to_i < 10
      day_number = "0"+day_number.to_s
    end
    for i in 0...appointments_to_create.length-1
      the_start_time = "#{day_number} #{months[month_number.to_s]} 2019 #{appointments_to_create[i]}:00:00 UTC +00:00"
      the_end_time = "#{day_number} #{months[month_number.to_s]} 2019 #{appointments_to_create[i+1]}:00:00 UTC +00:00"
      puts the_start_time
      Appointment.create!(service_id: the_service_id, start_time: the_start_time, end_time: the_end_time)
    end
  end
  # "17 Jan 2019 20:00:51 UTC +00:00"

  def Appointment.create_times(start_time, end_time)
    result = [start_time]
    until start_time == end_time
      split_time = start_time.split("")
      if split_time[0] == "0"
        if split_time[1] == "9"
          start_time = "10"
        else
          start_time = "0" + (split_time[1].to_i + 1).to_s
        end
      else
        if start_time == "24"
          start_time = "00"
        elsif start_time == "19"
          start_time = "20"
        else
          start_time = split_time[0] + (split_time[1].to_i + 1).to_s
        end
      end
      result.push(start_time)
    end
    # result.push(start_time)
    return result
  end
end
