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

    description = "Activity: #{@activity.activity_name} \n Location: #{@activity.format_full_location} \n Date: #{@activity.format_start_date} - #{@activity.format_end_date} \n Activity id: #{@activity.id} \n User id: #{current_user.id} \n User Email: #{current_user.email}"

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      # put user id email and activity id
      :description => description,
      :currency    => 'usd'
    )
    # if charge.Paid
    if charge.status == "succeeded"
      @activity_ticket = ActivityTicket.new(user_id: current_user.id, activity_id: @activity.id)
      if @activity_ticket.save
        return redirect_to user_path(current_user), :flash => { :success => "Purchased 1 spot for $#{@activity.cost}"}

        # redirect_to signup_path, :flash => { :error => @user.errors.full_messages.join(", ") }

      else
        flash[:error] = "I'm sorry your payment did not go through"
        render :new
      end
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    return redirect_to :root
  end
end
