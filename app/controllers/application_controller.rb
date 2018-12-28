class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  helper_method :user_logged_in?, :agreements_signed?

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
