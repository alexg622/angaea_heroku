class ServiceTicketsController < ApplicationController
  before_action :logged_in_user

  def spots
    @service = Service.find(params[:service_id])
    @service_ticket = ServiceTicket.new
  end

  def create_spots
    @service = Service.find(params[:activity_id])
    @service_ticket = current_user.service_tickets.find_by(activity_id: @service.id)
    if @service_ticket
      if @service_ticket.update_attributes(spots_buying: service_tickets_params[:spots_buying])
        return redirect_to new_activity_activity_ticket_path(@service)
      end
    end
    @service_ticket = ServiceTicket.new(user_id: current_user.id, activity_id: @service.id, spots_buying: service_tickets_params[:spots_buying])
    if @service_ticket.save
      redirect_to new_activity_activity_ticket_path(@service)
    else
      flash.now[:error] = @service_ticket.errors.full_messages
      render 'spots'
    end
  end

  def new
    @service = Service.find(params[:service_id])
    @service_ticket = ServiceTicket.new
    # @spots = current_user.service_tickets.find_by(activity_id: @service.id)
    # @total = ((@spots.spots_buying.to_f*@service.cost.to_f*1.10 * 10**2).round.to_f / 10**2)
    # @transFee = ((@spots.spots_buying*@service.cost.to_f*0.10 * 10**2).round.to_f / 10**2)
  end

  def create
    # Amount in cents
    @service = Service.find(params[:service_id])

    @service_ticket = current_user.service_tickets.find_by(service_id: @service.id)
    if @service_ticket
      redirect_to user_path(current_user)
    else
      @service_ticket = ServiceTicket.new(user_id: current_user.id, service_id: @service.id)
      if !@service_ticket.save
        flash.now[:error] = @service_ticket.errors.full_messages
        return  render 'new'
      end
    end

    @amount = (@service.cost.to_i*110)
    description = "Service: #{@service.service_name} \n Location: #{@service.format_full_location} \n Date: #{@service_ticket.day} \n Service id: #{@service.id} \n User id: #{current_user.id} \n User Email: #{current_user.email} \n Service Amount: $#{@service.cost} \n Transaction Fee: $#{((@service.cost.to_f*0.10 * 10**2).round.to_f / 10**2)} \n Total: $#{((((@service.cost.to_f*1.10))* 10**2).round.to_f) / 10**2}"

    if @service.cost == "0"
      AngaeaActivationMailer.send_service_info(current_user, @service, @service_ticket).deliver
      return redirect_to user_path(current_user), :flash => { :success => "Purchased 1 spot for $#{(@service.cost.to_f*1.10 * 10**2).round.to_f / 10**2}"}
    end

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )


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
      AngaeaActivationMailer.send_service_info(current_user, @service, @service_ticket).deliver
      return redirect_to user_path(current_user) && return#, :flash => { :success => "Purchased 1 spot for $#{(@service.cost.to_f*1.10 * 10**2).round.to_f / 10**2}"}
        # redirect_to signup_path, :flash => { :error => @user.errors.full_messages.join(", ") }
    else
      flash[:error] = "I'm sorry your payment did not go through"
      render :new && return 
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    return redirect_to :root
  end

  private
  def service_tickets_params
    params.require(:service_tickets).permit(:spots_buying)
  end

  def spot_count_params
    params.require(:spot_count).permit(:spots)
  end
end
