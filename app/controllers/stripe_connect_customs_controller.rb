# create account
# create stripe object for user
# store id and everything in stripe object
# agree to terms of service
# pass extra info throught meta data ex.
# response["metadata"]["userId"]
class StripeConnectCustomsController < ApplicationController
  before_action :user_logged_in?
  before_action :stripe?, only: [:new_stripe_account]

  def new_stripe_account
    @user = User.find(params[:user_id])
  end

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
      @stripe_connect = StripeConnect.new(user_id: @user.id, accountId: response["id"])

      if @stripe_connect.save
        redirect_to "/stripe/#{@user.id}/terms/new"
      else
        flash.now[:errors] = @stripe_connect.errors.full_messages
        render "new_stripe_account"
      end
    rescue Stripe::InvalidRequestError => e
      flash.now[:errors] = e
      return render "new_stripe_account"
    end
    # save to user stripe object
  end

  def new_agree_stripe_terms
    @user = User.find(params[:user_id])
  end

  def create_agree_stripe_terms
    @user = current_user
    Stripe.api_key = ENV["SECRET_KEY"]
    begin
      acct = Stripe::Account.retrieve(@user.stripe_connect.accountId)
      acct.tos_acceptance.date = Time.now.to_i
      acct.tos_acceptance.ip = request.remote_ip # Assumes you're not using a proxy
      acct.save
      if @user.stripe_connect.update_attributes(acceptance_date: acct.tos_acceptance.date, acceptance_ip: acct.tos_acceptance.ip)
        redirect_to "/stripe/#{@user.id}/stripe_acct_details"
      else
        flash.now[:error] = @user.stripe_connect.errors.full_messages
        render "new_agree_stripe_terms"
      end
    rescue => e
      flash.now[:error] = e
      render "new_agree_stripe_terms"
    end
  end

  def new_stripe_acct_details
    @user = User.find(params[:user_id])
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
        flash[:success] = "Payment Information Successfully Submitted"
        redirect_to "/stripe/#{@user.id}/stripe_acct"
      else
        flash.now[:error] = @user.errors.full_messages
        render "new_stripe_acct_details"
      end

    rescue => e
      flash.now[:error] = e

      render "new_stripe_acct_details"
    end
  end

  def update_stripe_acct_details
    @user = User.find(params[:user_id])
    if @user.stripe_connect == nil
      flash.now[:error] = "Looks like you don't have a stripe account. Let's get you start in making one!"
      return redirect_to "/stripe/#{@user.id}/new"
    end

    Stripe.api_key = ENV["SECRET_KEY"]

    begin
      @acct = Stripe::Account.retrieve(@user.stripe_connect.accountId)
      if @acct.external_accounts.data == []
        flash.now[:error] = "Looks like you don't have a bank account set up with stripe. Lets get you started!"
        redirect_to "/stripe/#{@user.id}/terms/new"
      end
    rescue => e
      flash.now[:error] = e
      render "update_stripe_acct_details"
    end
  end

  def create_update_stripe_acct_details
    @user = User.fin(params[:user_id])
    begin
      @acct = Stripe::Account.retrieve(@user.stripe_connect.accountId)

      @acct.legal_entity.address.city = stripe_connect_params[:city]
      @acct.legal_entity.address.line1 = stripe_connect_params[:address_line1]
      @acct.legal_entity.address.postal_code = stripe_connect_params[:postal_code]
      @acct.legal_entity.address.state = stripe_connect_params[:state]
      @acct.legal_entity.dob.day = stripe_connect_params[:dob_day]
      @acct.legal_entity.dob.month = stripe_connect_params[:dob_month]
      @acct.legal_entity.dob.year = stripe_connect_params[:dob_year]
      @acct.legal_entity.first_name = stripe_connect_params[:first_name]
      @acct.legal_entity.last_name = stripe_connect_params[:last_name]
      @acct.legal_entity.ssn_last_4 = stripe_connect_params[:ssn_last_4]
      @acct.legal_entity.type = stripe_connect_params[:entity_type]
      @acct.metadata.activity_creator_id = @user.id
      @acct.legal_entity.business_name = stripe_connect_params[:business_name]
      @acct.legal_entity.business_tax_id = stripe_connect_params[:business_tax_id]
      @acct.save

      flash[:success] = "Stripe Acct Successfully Updated"
      return redirect_to user_path(@user)
    rescue => e
      flash.now[:error] = e
      return render "update_stripe_acct_details"
    end
  end

  def stripe_acct
    @user = User.find(params[:user_id])
  end

  def delete_stripe_acct
    @user = User.find(params[:user_id])
    if @user.stripe_connect.destroy
      redirect_to "/stripe/#{@user.id}/stripe_acct"
    else
      flash.now[:error] = @user.errors.full_messages
      render "stripe_acct"
    end
  end

  private
  def stripe_connect_params
    params.require(:stripe_connect).permit(:state, :routing_number, :dob_month, :business_name, :business_tax_id, :account_number, :account_holder_type, :city, :address_line1, :postal_code, :dob_day, :dob_year, :first_name, :last_name, :ssn_last_4, :entity_type)
  end
end
