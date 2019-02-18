class UsersController < ApplicationController
 before_action :logged_in_user, only: [:index, :edit, :update]
 before_action :correct_user, only: [:edit, :update]
 before_action :agreements_signed?, only: [:show, :edit, :update, :index]
 before_action :account_activated?, only: [:show, :edit, :update, :index]
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
       @user = User.new(email_list: user_params[:email_list], city: user_params[:city], state: user_params[:state], address: user_params[:address], zipcode: user_params[:zipcode], account_activation_secret: SecureRandom.urlsafe_base64(16), agree_to_terms: "true", agree_to_privacy: "true", password: user_params[:password], password_confirmation: user_params[:password_confirmation], facebook: user_params[:facebook], instagram: user_params[:instagram], twitter: user_params[:twitter], pinterest: user_params[:pinterest], youtube: user_params[:youtube], about: user_params[:about], name: user_params[:name], email: user_params[:email], profession: user_params[:profession], skills: user_params[:skills])
       if @user.save
         AngaeaActivationMailer.send_activation_link(@user).deliver
         log_in @user
         # flash[:success] = "Welcome to the Sample App!"
         redirect_to user_path(@user)  #redirect_to user_url(@user)
       else
         # flash.now[:error] = @user.errors.full_messages.join(", ")
         # flash[:error] = @user.errors.full_messages.join(", ")
         # return  render "new"
         return redirect_to signup_path, :flash => { :error => @user.errors.full_messages.join(", ") }
       end
     else
       flash.now[:error] = "Please agree to the terms and conditions"
       # render_to 'new'
       # flash[:error] = "Please agree to the terms and conditions"
       # render "new"
       # redirect_to signup_path, :flash => { :error => "Please agree to the terms and conditions" }
     end
   end
   #forgot to add log in user before that s why it didnt work

  def activate_account
    @user = User.find_by(account_activation_secret: params[:activation_id])
  end

  # def activation_reminder
  #
  # end

  def create_activate_account
    @user = User.find_by(account_activation_secret: params[:activation_id])
    if @user.update_attributes(account_activated: "true")

      AngaeaActivationMailer.post_activation_email(@user).deliver
      flash.now[:success] = "Account Activated!"
      redirect_to user_path(@user)
    else
      flash.now[:error] = "Activation failed. Please try again!"
      redirect_to root_path
    end
  end

  def edit
      @user = User.find(params[:id])
   end


 def update
   @user = User.find(params[:id])
   if user_params[:image]
     @user.image.attach(user_params[:image])
   end

   if @user.image.attached? && @user.update_attributes(email_list: user_params[:email_list], city: user_params[:city], state: user_params[:state], address: user_params[:address], zipcode: user_params[:zipcode], facebook: user_params[:facebook], instagram: user_params[:instagram], twitter: user_params[:twitter], pinterest: user_params[:pinterest], youtube: user_params[:youtube], about: user_params[:about], name: user_params[:name], email: user_params[:email], profession: user_params[:profession], skills: user_params[:skills])
     flash[:success] = "Profile updated"
     redirect_to @user
   else
     flash.now[:error] = @user.errors.full_messages.join(", ") + (@user.errors.full_messages.length == 0 ? "please attach an image and fill out your password" : ", please attach an image")
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

   def update_password
     @user = User.find(params[:id])
   end

   def create_update_password
     @user = User.find(params[:id])
     if @user.authenticate(user_params[:password])
       if user_params[:new_password] == user_params[:password_confirmation]
         if @user.update_attributes(password: user_params[:new_password])
           flash[:success] = "Password Updated"
           return redirect_to user_path(@user)
         else
           flash.now[:error] = @user.errors.full_messages
           return render "update_password"
         end
       else
         flash.now[:error] = "Passwords do not match"
         return render "update_password"
       end
     else
       flash.now[:error] = "Password is incorrect"
       return render "update_password"
     end
   end


   def reset_password_link
   end

   def create_reset_password_link
     @user = User.find_by(email: user_params[:email])
     reset_password_secret = SecureRandom.urlsafe_base64
     if @user
       if @user.update_attributes(reset_password_secret: reset_password_secret)
         AngaeaActivationMailer.send_reset_password_link(@user).deliver
         redirect_to "/users/resetPasswordNotification"
       else
         flash.now[:error] = @user.errors.full_messages
         render "reset_password_link"
       end
     else
       flash.now[:error] =  "Could not find user with that email."
       render "reset_password_link"
     end
   end

   def reset_password_notification
   end

   def reset_password
     @user = User.find_by(reset_password_secret: params[:id])
   end

   def create_reset_password
     @user = User.find_by(reset_password_secret: params[:id])
     if user_params[:password] == user_params[:new_password]
       if @user && @user.update_attributes(password: user_params[:new_password], city: @user.city, state: @user.state, zipcode: @user.zipcode)
         flash[:success] = "Password Updated"
         return redirect_to login_path
       else
         flash[:error] = @user.errors.full_messages
         return render "reset_password"
       end
    else
      flash[:error] = "Passwords do not match"
      return render "reset_password"
    end
   end

  private

    def user_params
      params.require(:user).permit(:city, :email_list, :state, :zipcode, :address, :new_password, :agree_to_terms, :facebook, :instagram, :youtube, :twitter, :pinterest, :image, :about, :name, :profession, :skills, :email, :password, :password_confirmation)
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
