class DaysController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @month_number = params[:month_id].to_i + 1
    @day_number = params[:day_id].to_i
    @not_booked = @user.get_not_booked(@month_number, @day_number)
    @booked = @user.get_booked(@month_number, @day_number)
    @appointment = Appointment.new
    @appointment_ticket = AppointmentTicket.new
  end

  def create
    @user = User.find(params[:user_id])
    @day_number = params[:day_id]
    @month_number = params[:month_id].to_i-1
    @number_of_appointments = Appointment.create_appointments(@user.id, days_params[:start_time], days_params[:end_time], @day_number, @month_number)
    redirect_to "/users/#{@user.id}/calendars"
  end

  def book_appointment
    @user = User.find(params[:user_id])
    @appointment = Appointment.find(params[:appointment_id])
    @appointment_ticket = AppointmentTicket.new(user_id: @user.id, appointment_id: @appointment.id)
    if @appointment_ticket.save
      if @appointment.update_attributes(booked: "true")
        redirect_to "/users/#{@user.id}"
      else
        flash.now[:error] = @appointment.errors.full_messages
        render "show"
      end
    else
      flash.now[:error] = @appointment_ticket.errors.full_messages
      render "show"
    end
  end

  def destroy
    @appointment = Appointment.find(params[:appointment_id])
    @appointment.destroy
    redirect_to "/users/#{current_user.id}/calendars"
  end

  private
  def days_params
    params.require(:day).permit(:start_time, :end_time)
  end
end
