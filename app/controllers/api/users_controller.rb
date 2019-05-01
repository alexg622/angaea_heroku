class Api::UsersController < ApplicationController
  protect_from_forgery with: :null_session
  def show
    begin
      p "inside the user part"
      p @user
      @user = User.find(params[:id])
    rescue => e
      render json: e
    end
  end

  def create
    if user_params[:agree_to_terms] == "true"
      @user = User.create!(user_params)
      if @user.save
        @user.image.attach(user_params[:image])
        log_in @user
        render "show", status: 200
      else
        error = {errors: "Please enter all required information"}
        render json: error, status: 401
      end
    else
      error = {errors: "Please agree to terms and conditions"}
      render json: error, status: 401
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :image, :city, :email, :state, :zipcode, :password, :password_confirmation, :profession, :about, :facebook, :instagram, :youtube, :twitter, :pinterest, :email_list, :agree_to_terms)
  end

  def user_image_params
    params.require(:user).permit(:image)
  end
end
