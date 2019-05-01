class Api::SessionsController < ApplicationController
  # include ActionController::Cookies
  # include ActionController::RequestForgeryProtection
  #
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      render "api/users/show"
    else
      error = {errors: "Invalid username/password combination"}
      render json: error, status: 401
    end
  end

  def destroy
   log_out if logged_in?
   response = {success: "User logged out"}
   render json: response, status: 200
 end

end
