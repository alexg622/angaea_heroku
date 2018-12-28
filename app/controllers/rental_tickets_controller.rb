class RentalTicketsController < ApplicationController
  before_action :logged_in_user

  def new
    @rental = Rental.find(params[:rental_id])
    @rental_ticket = RentalTicket.new
  end

  def create
    # Amount in cents
    @rental = Rental.find(params[:rental_id])
    @amount = @rental.cost.to_i*100

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )
    if charge.status == "succeeded"
      @rental_ticket = RentalTicket.new(user_id: current_user.id, rental_id: @rental.id)
      if @rental_ticket.save
        return redirect_to user_path(current_user)
      end
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    return redirect_to :root
  end
end
