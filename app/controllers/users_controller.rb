class UsersController < ApplicationController
 before_action :logged_in_user, only: [:index, :edit, :update]
 before_action :correct_user, only: [:edit, :update]
 before_action :agreements_signed?, only: [:show, :edit, :update, :index]
 # before_action :admin_user,     only: :destroy

 def index
   @users = User.all
 end


 def show
   @user = User.find(params[:id])
   @activity = Activity.new
   @rental = Rental.new
   @rentals = @user.rentals
   @upcoming_activities = @user.user_events
   @rented_items = @user.rented_items
   @activities = @user.activities #need on bottom of page
 end

 def new
   @user = User.new
 end

 def create
    if user_params[:agree_to_terms] == "true"
       @user = User.new(agree_to_terms: "true", agree_to_privacy: "true", password: user_params[:password], password_confirmation: user_params[:password_confirmation], facebook: user_params[:facebook], instagram: user_params[:instagram], twitter: user_params[:twitter], pinterest: user_params[:pinterest], youtube: user_params[:youtube], about: user_params[:about], name: user_params[:name], email: user_params[:email], profession: user_params[:profession], skills: user_params[:skills])
       if @user.save
         log_in @user
         # flash[:success] = "Welcome to the Sample App!"
         redirect_to user_path(@user)  #redirect_to user_url(@user)
       else
         # flash.now[:error] = @user.errors.full_messages.join(", ")
         redirect_to signup_path, :flash => { :error => @user.errors.full_messages.join(", ") }
       end
     else
       # flash.now[:error] = "Please agree to the terms and conditions"
       # render_to 'new'
       redirect_to signup_path, :flash => { :error => "Please agree to the terms and conditions" }
     end
   end
   #forgot to add log in user before that s why it didnt work

  def edit
      @user = User.find(params[:id])
   end


 def update
   @user = User.find(params[:id])
   if user_params[:image]
     @user.image.attach(user_params[:image])
   end

   if @user.image.attached? && @user.update_attributes(facebook: user_params[:facebook], instagram: user_params[:instagram], twitter: user_params[:twitter], pinterest: user_params[:pinterest], youtube: user_params[:youtube], about: user_params[:about], name: user_params[:name], email: user_params[:email], profession: user_params[:profession], skills: user_params[:skills]) && @user.authenticate(user_params[:password])
     flash[:success] = "Profile updated"
     redirect_to @user
   else
     flash.now[:error] = @user.errors.full_messages.join(", ") + (@user.errors.full_messages.length == 0 ? "please attach an image and fill out your password" : ", please attach an image and fill out your password")
     render 'edit'
   end
 end

 def destroy
  if current_user.destroy
  end
  flash[:success] = "User deleted"
  redirect_to root_path
end

   def correct_user
     @user = User.find(params[:id])
     redirect_to(root_url) unless @user == current_user
   end

  private

    def user_params
      params.require(:user).permit(:agree_to_terms, :facebook, :instagram, :youtube, :twitter, :pinterest, :image, :about, :name, :profession, :skills, :email, :password, :password_confirmation)
    end
        # Confirms a logged-in user.
   def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
   end

   # Confirms the correct user.
   def correct_user
     @user = User.find(params[:id])
     redirect_to(root_url) unless current_user?(@user)
   end
end


# def admin_user
#      redirect_to(root_url) unless current_user.admin?
#    end
