# create account
# create stripe object for user
# store id and everything in stripe object
# agree to terms of service
# pass extra info throught meta data ex.
# response["metadata"]["userId"]
class Api::StripesController < ApplicationController
  before_action :user_logged_in?

  def create_stripe_account
    @user = User.find(params[:user_id])
    email = @user.email

    Stripe.api_key = ENV["SECRET_KEY"]

    begin
      response = Stripe::Account.create(
        :type => 'custom',
        :country => 'US',
        :email => email
      )

      response.metadata.user_id = current_user.id
      response.save

      @stripe_connect = StripeConnect.create!(user_id: @user.id, accountId: response["id"])

      if @stripe_connect.save
        return render 'api/users/show', status: 200
      else
        return render json: {error: @stripe_connect.errors.full_messages}, status: 500
      end
    rescue Stripe::InvalidRequestError => e
      return render json: {error: e}, status: 500
    end
    # save to user stripe object
  end

  def create_agree_stripe_terms
    @user = User.find(params[:user_id])
    Stripe.api_key = ENV["SECRET_KEY"]

    begin
      acct = Stripe::Account.retrieve(@user.stripe_connect.accountId)
      acct.tos_acceptance.date = Time.now.to_i
      acct.tos_acceptance.ip = request.remote_ip # Assumes you're not using a proxy
      acct.save

      accept_date = DateTime.new(acct.tos_acceptance.date.to_i)

      if @user.stripe_connect.update_attributes(acceptance_ip: acct.tos_acceptance.ip)
        return render 'api/users/show', status: 200
      else
        errors = @user.stripe_connect.errors.full_messages
        render json: {error: errors}, status: 500
      end
    rescue => e
      render json: {error: e}, status: 500
    end
  end

  def stripe_acct_details_create
    @user = User.find(params[:user_id])
    Stripe.api_key = ENV["SECRET_KEY"]
    begin
      acct = Stripe::Account.retrieve(@user.stripe_connect.accountId)

      stripe_token = Stripe::Token.create(
        bank_account: {
          country: "US",
          currency: "usd",
          account_holder_name: stripe_connect_params[:first_name] + stripe_connect_params[:last_name],
          account_holder_type: stripe_connect_params[:entity_type],
          routing_number: stripe_connect_params[:routing_number],
          account_number: stripe_connect_params[:account_number],
        },
      )

      acct.legal_entity.address.city = stripe_connect_params[:city]
      acct.legal_entity.address.line1 = stripe_connect_params[:address_line1]
      acct.legal_entity.address.postal_code = stripe_connect_params[:postal_code]
      acct.legal_entity.address.state = stripe_connect_params[:state]
      acct.legal_entity.dob.day = stripe_connect_params[:dob_day]
      acct.legal_entity.dob.month = stripe_connect_params[:dob_month]
      acct.legal_entity.dob.year = stripe_connect_params[:dob_year]
      acct.legal_entity.first_name = stripe_connect_params[:first_name]
      acct.legal_entity.last_name = stripe_connect_params[:last_name]
      acct.legal_entity.ssn_last_4 = stripe_connect_params[:ssn_last_4]
      acct.legal_entity.type = stripe_connect_params[:entity_type]
      acct.legal_entity.business_name = stripe_connect_params[:business_name].present? ? stripe_connect_params[:business_name] : nil
      acct.legal_entity.business_tax_id = stripe_connect_params[:business_tax_id].present? ? stripe_connect_params[:business_tax_id] : nil
      acct.metadata.activity_creator_id = @user.id
      acct.save

      acct.external_accounts.create(:external_account => stripe_token)

      if @user.stripe_connect.update_attributes(account_number: stripe_connect_params[:account_number][-4..-1], routing_number: stripe_connect_params[:routing_number])
        # redirect_to "/stripe/#{@user.id}/stripe_acct"
        return render 'api/users/show', status: 200
      else
        error_message = @user.errors.full_messages
        return render json: {error: error_message}, status: 500
      end

    rescue => e
      error_message = e
      render json: {error: error_message}, status: 500
    end

  end

  def delete_stripe_acct
    @user = User.find(params[:user_id])
    if @user.stripe_connect.destroy
      return render "api/users/show", status: 200
    else
      error_message = @user.errors.full_messages
      return render json: {error: error_message}, status: 500
    end
  end

  private
  def stripe_connect_params
    params.require(:stripe_connect).permit(:state, :routing_number, :dob_month, :business_name, :business_tax_id, :account_number, :account_holder_type, :city, :address_line1, :postal_code, :dob_day, :dob_year, :first_name, :last_name, :ssn_last_4, :entity_type)
  end
end
