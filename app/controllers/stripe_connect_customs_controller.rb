# create account
# create stripe object for user
# store id and everything in stripe object
# agree to terms of service
# pass extra info throught meta data ex.
# response["metadata"]["userId"]
class StripeConnectCustomsController < ApplicationController
  before_action :user_logged_in?

  def new_stripe_account
    @user = User.find(params[:user_id])
    @activity = @user.activities.find(params[:activity_id])
  end

  def create_stripe_account
    @user = User.find(params[:user_id])
    @activity = @user.activities.find(params[:activity_id])
    email = @user.email

    Stripe.api_key = ENV["SECRET_KEY"]

    begin
      response = Stripe::Account.create(
        :type => 'custom',
        :country => 'US',
        :email => email
      )
    rescue Stripe::InvalidRequestError => e
      flash.now[:errors] = e
      return render "new_stripe_account"
    end
    # save to user stripe object
    account_id = response["id"]
    p account_id
    redirect_to '/stripe/#{@user.id}/#{@activity.id}/terms/new'
  end

  def new_agree_stripe_terms
    @user = User.find(params[:user_id])
    @activity = @user.activities.find(params[:activity_id])
  end

  def create_agree_stripe_terms
    @user = current_user
    @activity = @user.activities.find(params[:activity_id])
    Stripe.api_key = ENV["SECRET_KEY"]
    begin
      acct = Stripe::Account.retrieve(@user.stripe.account_id)
      acct.tos_acceptance.date = Time.now.to_i
      acct.tos_acceptance.ip = request.remote_ip # Assumes you're not using a proxy
      acct.save
    rescue => e
      flash.now[:error] = e
      render "new_agree_stripe_terms"
    end
  end

end
