class Api::ActivityTicketsController < ApplicationController
  protect_from_forgery with: :null_session
  
  def create
    @activity = Activity.find(params[:activity_id])
    @spots = params[:numberOfSpots]
    @total = params[:total]
    @amount = (@total.to_f * 100).to_i
    @email = params[:email]

    description = "Service: #{@activity.activity_name} \n Location: #{@activity.format_full_location} \n Date: #{@activity.format_start_date} - #{@activity.format_end_date} \n Service id: #{@activity.id} \n User Email: #{@email} \n Service Amount: $#{@activity.cost} \n Transaction Fee: $#{((@activity.cost.to_f*0.10 * 10**2).round.to_f / 10**2)*@spots.to_f} \n Spots Purchased: #{@spots} \n Total: $#{((((@activity.cost.to_f*1.10)*@spots.to_f)* 10**2).round.to_f) / 10**2}"

    if @activity.cost == "0"
      if @spots.to_int == 1
        AngaeaActivationMailer.send_api_activity_info(@activity, @spots, @email).deliver
        return render json: {success: true}, status: 200
      else
        AngaeaActivationMailer.send_api_activity_info(@activity, @spots, @email).deliver
        return render json: {success: true}, status: 200
      end
    end

    @email = params[:email].present? ? params[:email] : params[:jsonToken][:email]

    customer = Stripe::Customer.create(
      :email => @email,
      :source  => params[:jsonToken][:id]
    )

    charge = Stripe::Charge.create({
      customer:     customer.id,
      amount:       @amount,
      # put user id email and activity id
      description:  description,
      currency:     'usd',
      receipt_email: customer.email
    })

    if charge.status == "succeeded"
      if @spots == 1
        AngaeaActivationMailer.send_api_activity_info(@activity, @spots, @email).deliver
        return render json: {success: true}, status: 200
      else
        AngaeaActivationMailer.send_api_activity_info(@activity, @spots, @email).deliver
        return render json: {success: true}, status: 200
      end
        # redirect_to signup_path, :flash => { :error => @user.errors.full_messages.join(", ") }
      return render json: {error: "I'm sorry your payment did not go through"}, status: 500
    end
    rescue Stripe::CardError => e
    return render json: {error: e.message}, status: 500
  end

end
