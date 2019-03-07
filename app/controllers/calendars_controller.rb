class CalendarsController < ApplicationController

  def show
    @user = User.find(params[:user_id])
    @appointment = Appointment.new
    @appointment_ticket = AppointmentTicket.new
  end

  def show_appointments
    @user = User.find(params[:user_id])
    @booked_appointments = @user.show_booked_appointments
    @not_booked_appointments = @user.show_unbooked_appointments
    @appointments = {
      bookedAppointments: @booked_appointments,
      notBookedAppointments: @not_booked_appointments
    }
    render json: @appointments
  end
end
