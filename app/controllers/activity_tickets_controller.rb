class ActivityTicketsController < ApplicationController
  before_action :logged_in_user

  def spots
    @activity = Activity.find(params[:activity_id])
    @activity_ticket = ActivityTicket.new
  end

  def create_spots
    @activity = Activity.find(params[:activity_id])
    @activity_ticket = current_user.activity_tickets.find_by(activity_id: @activity.id)
    if @activity_ticket
      if @activity_ticket.update_attributes(spots_buying: activity_tickets_params[:spots_buying])
        return redirect_to new_activity_activity_ticket_path(@activity)
      end
    end
    @activity_ticket = ActivityTicket.new(user_id: current_user.id, activity_id: @activity.id, spots_buying: activity_tickets_params[:spots_buying])
    if @activity_ticket.save
      redirect_to new_activity_activity_ticket_path(@activity)
    else
      flash.now[:error] = @activity_ticket.errors.full_messages
      render 'spots'
    end
  end

  def new
    @activity = Activity.find(params[:activity_id])
    @activity_ticket = ActivityTicket.new
    # @spots = current_user.activity_tickets.find_by(activity_id: @activity.id)
    # @total = ((@spots.spots_buying.to_f*@activity.cost.to_f*1.10 * 10**2).round.to_f / 10**2)
    # @transFee = ((@spots.spots_buying*@activity.cost.to_f*0.10 * 10**2).round.to_f / 10**2)
  end

  def create
    # Amount in cents
    @activity = Activity.find(params[:activity_id])

    @activity_ticket = current_user.activity_tickets.find_by(activity_id: @activity.id)
    if @activity_ticket
      if !@activity_ticket.update_attributes(spots_buying: spot_count_params[:spots])
        flash.now[:error] = @activity_ticket.errors.full_messages
        return render "new"
      end
    else
      @activity_ticket = ActivityTicket.new(user_id: current_user.id, activity_id: @activity.id, spots_buying: spot_count_params[:spots])
      if !@activity_ticket.save
        flash.now[:error] = @activity_ticket.errors.full_messages
        return  render 'new'
      end
    end

    @spots = current_user.activity_tickets.find_by(activity_id: @activity.id)
    @amount = (@activity.cost.to_i*110)*@spots.spots_buying

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    description = "Service: #{@activity.activity_name} \n Location: #{@activity.format_full_location} \n Date: #{@activity.format_start_date} - #{@activity.format_end_date} \n Service id: #{@activity.id} \n User id: #{current_user.id} \n User Email: #{current_user.email} \n Service Amount: $#{@activity.cost} \n Transaction Fee: $#{((@activity.cost.to_f*0.10 * 10**2).round.to_f / 10**2)*@spots.spots_buying.to_f} \n Spots Purchased: #{@spots.spots_buying} \n Total: $#{((@activity.cost.to_f*1.10 * 10**2).round.to_f / 10**2)*@spots.spots_buying.to_f}"
    charge = Stripe::Charge.create({
      customer:     customer.id,
      amount:       @amount,
      # put user id email and activity id
      description:  description,
      currency:     'usd',
      receipt_email: customer.email
    })
    # if charge.Paid
    if charge.status == "succeeded"
      if @spots.spots_buying == 1
        AngaeaActivationMailer.send_activity_info(current_user, @activity, @spots).deliver
        return redirect_to user_path(current_user), :flash => { :success => "Purchased 1 spot for $#{(@activity.cost.to_f*1.10 * 10**2).round.to_f / 10**2}"}
      else
        AngaeaActivationMailer.send_activity_info(current_user, @activity, @spots).deliver
        return redirect_to user_path(current_user), :flash => { :success => "Purchased #{@spots.spots_buying} spots for $#{((@activity.cost.to_f*1.10 * 10**2).round.to_f / 10**2)*@spots.spots_buying.to_f}"}
      end
        # redirect_to signup_path, :flash => { :error => @user.errors.full_messages.join(", ") }
      flash[:error] = "I'm sorry your payment did not go through"
      render :new
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    return redirect_to :root
  end

  private
  def activity_tickets_params
    params.require(:activity_tickets).permit(:spots_buying)
  end

  def spot_count_params
    params.require(:spot_count).permit(:spots)
  end
end
