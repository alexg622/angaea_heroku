class ActivityTicketsController < ApplicationController
  before_action :logged_in_user 

  def new
    @activity = Activity.find(params[:activity_id])
    @activity_ticket = ActivityTicket.new
  end

  def create
    # Amount in cents
    @activity = Activity.find(params[:activity_id])
    @amount = @activity.cost.to_i*100
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
        @activity_ticket = ActivityTicket.new(user_id: current_user.id, activity_id: @activity.id)
        if @activity_ticket.save
          return redirect_to user_path(current_user)
        end
      end
    rescue Stripe::CardError => e
      flash[:error] = e.message
      return redirect_to :root
    end
end
