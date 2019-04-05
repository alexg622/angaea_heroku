class SessionsController < ApplicationController
  before_action
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user.locked == "true"
      return redirect_to root_path, :flash => { :error => "Your account is temporarily locked while we go over your profile. You will receive an email shortly letting you know that we have unlocked your account." }
    end
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
