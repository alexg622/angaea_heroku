class RentalTicketsController < ApplicationController
  before_action :logged_in_user

  # def new_days_renting
  #   @rental = Rental.find(params[:rental_id])
  #   @rental_ticket = RentalTicket.new
  # end

  def days_renting
    @rental = Rental.find(params[:rental_id])
    @rental_ticket = RentalTicket.new
  end

  def create_days_renting
    @rental = Rental.find(params[:rental_id])
    @rental_ticket = current_user.rental_tickets.find_by(rental_id: @rental.id)
    if @rental_ticket
      if @rental_ticket.update_attributes(days_renting: rental_tickets_params[:days_renting])
        return redirect_to new_rental_rental_ticket_path(@rental)
      end
    end
    @rental_ticket = RentalTicket.new(user_id: current_user.id, rental_id: @rental.id, days_renting: rental_tickets_params[:days_renting])
    if @rental_ticket.save
      redirect_to new_rental_rental_ticket_path(@rental)
    else
      flash.now[:error] = @rental_ticket.errors.full_messages
      render 'spots'
    end
  end

  def new
    @rental = Rental.find(params[:rental_id])
    @rental_ticket = RentalTicket.new
    @days = current_user.rental_tickets.find_by(rental_id: @rental.id)
    @total = ((@days.days_renting.to_f*@rental.cost.to_f*1.10 * 10**2).round.to_f / 10**2)
    @transFee = ((@days.days_renting*@rental.cost.to_f*0.10 * 10**2).round.to_f / 10**2)
  end

  def create
    # Amount in cents
    @rental = Rental.find(params[:rental_id])
    @days = current_user.rental_tickets.find_by(rental_id: @rental.id)
    @amount = (@rental.cost.to_i*110)*@days.days_renting
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )
    description = "Rental: #{@rental.rental_name} \n Rental id: #{@rental.id} \n User id: #{current_user.id} \n User Email: #{current_user.email} \n Days Renting: #{@days.days_renting} \n Rental Amount per Day: $#{@rental.cost} \n Transaction Fee: $#{((@rental.cost.to_f*0.10 * 10**2).round.to_f / 10**2)*@days.days_renting.to_f} \n Total: $#{((@rental.cost.to_f*1.10 * 10**2).round.to_f / 10**2)*@days.days_renting.to_f}"
    charge = Stripe::Charge.create({
      customer:     customer.id,
      amount:       @amount,
      # put user id email and rental id
      description:  description,
      currency:     'usd',
      receipt_email: customer.email
    })
    # if charge.Paid
    if charge.status == "succeeded"
      if @days.days_renting == 1
        return redirect_to user_path(current_user), :flash => { :success => "Purchased rental for #{@days.days_renting} day at $#{(@rental.cost.to_f*1.10 * 10**2).round.to_f / 10**2} per day for a total of #{((@rental.cost.to_f*1.10 * 10**2).round.to_f / 10**2)*@days.days_renting.to_f}"}
      else
        return redirect_to user_path(current_user), :flash => { :success => "Purchased rental for #{@days.days_renting} days at $#{(@rental.cost.to_f*1.10 * 10**2).round.to_f / 10**2} per day for a total of #{((@rental.cost.to_f*1.10 * 10**2).round.to_f / 10**2)*@days.days_renting.to_f}"}
      end
        # redirect_to signup_path, :flash => { :error => @user.errors.full_messages.join(", ") }
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    return redirect_to :root
  end
  private
  def rental_tickets_params
    params.require(:rental_tickets).permit(:days_renting)
  end
end
