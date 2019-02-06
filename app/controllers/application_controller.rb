class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  helper_method :user_logged_in?, :agreements_signed?, :stripe?, :activity_no_stripe

  private

    # Confirms a logged-in user.
  def agreements_signed?
    if current_user
      if current_user.agree_to_terms && current_user.agree_to_privacy
        return
      else
        redirect_to "/termsConditions"
      end
    end
  end

  def stripe?
    if current_user
      if current_user.stripe_connect != nil
        redirect_to user_path(current_user)
      end
    end
  end

  def activity_no_stripe
    if current_user
      if current_user.stripe_connect == nil
        flash.now[:error] = "Before creating an activity please create a stripe account so that we can pay after the activity is completed."
        return redirect_to "/stripe/#{current_user}/new"
      end
      if current_user.stripe_connect.account_number == nil
        flash.now[:error] = "Please agree to stripes terms and conditions and complete your account with them!"
        return redirect_to "/stripe/#{current_user.id}/terms/new}"
      end
    end
  end

  def account_activated?
    if current_user
      if current_user.account_activated != "true"
        redirect_to '/users/activation_reminder'
      end
    end
  end

  def user_logged_in?
    if current_user
      return
    else
      redirect_to login_path
    end
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
