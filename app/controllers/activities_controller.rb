class ActivitiesController < ApplicationController
  before_action :agreements_signed?

  def create
    @user = current_user

    @activity = Activity.new(capacity: activity_params[:capacity], contact_number: activity_params[:contact_number], contact_email: activity_params[:contact_email], activity_name: activity_params[:activity_name], content: activity_params[:content], additional_info: activity_params[:additional_info], user_id: current_user.id, start_date: activity_params[:start_date], end_date: activity_params[:end_date], addressLN1: activity_params[:addressLN1], addressLN2: activity_params[:addressLN2], city: activity_params[:city], state: activity_params[:state], cost: activity_params[:cost], zip: activity_params[:zip])
    @category = Category.find_by(category_name: activity_params[:category])
    if @activity.save && @user.update_attributes(account_number: user_params[:account_number], routing_number: user_params[:routing_number])
      # @activity.image.attach(activity_params[:image])
      if activity_params[:image]
        @activity.image.attach(activity_params[:image])
      end

      if activity_params[:images]
        @activity.images.attach(activity_params[:images])
      end

      @tag = Tag.new(activity_id: @activity.id, category_id: @category.id)
      if @tag.save
        redirect_to user_path(current_user)
      end
    else
      @user = current_user
      redirect_to user_path(current_user), :flash => { :error => @activity.errors.full_messages.join(", ") }
    end
  end

 def show
   @activity = Activity.find(params[:id])
   @tags = @activity.categories
 end

 def edit
   @activity = current_user.activities.find(params[:id])
 end

  def update
    @activity = current_user.activities.find(params[:id])
    if activity_params[:image]
      @activity.image.attach(activity_params[:image])
    end

    if activity_params[:images]
      @activity.images.attach(activity_params[:images])
    end

    if activity_params[:start_date] == "" && activity_params[:end_date] == ""
      if @activity.image.attached? && @activity.update_attributes(capacity: activity_params[:capacity], contact_number: activity_params[:contact_number], contact_email: activity_params[:contact_email], activity_name: activity_params[:activity_name], content: activity_params[:content], additional_info: activity_params[:additional_info], user_id: current_user.id, start_date: @activity.start_date, end_date: @activity.end_date, addressLN1: activity_params[:addressLN1], addressLN2: activity_params[:addressLN2], city: activity_params[:city], state: activity_params[:state], cost: activity_params[:cost], zip: activity_params[:zip])
        redirect_to user_path(current_user)
      else
        flash.now[:error] = @activity.errors.full_messages.join(", ") + (@activity.errors.full_messages.length == 0 ? "please attach a picture" : ", please attach a picture")
        render "edit"
      end
    elsif activity_params[:start_date] == ""
      if @activity.image.attached? && @activity.update_attributes(capacity: activity_params[:capacity], contact_number: activity_params[:contact_number], contact_email: activity_params[:contact_email], activity_name: activity_params[:activity_name], content: activity_params[:content], additional_info: activity_params[:additional_info], user_id: current_user.id, start_date: @activity.start_date, end_date: activity_params[:end_date], picture: activity_params[:picture], addressLN1: activity_params[:addressLN1], addressLN2: activity_params[:addressLN2], city: activity_params[:city], state: activity_params[:state], cost: activity_params[:cost], zip: activity_params[:zip])
        redirect_to user_path(current_user)
      else
        flash.now[:error] = @activity.errors.full_messages.join(", ") + (@activity.errors.full_messages.length == 0 ? "please attach a picture" : ", please attach a picture")
        render "edit"
      end
    elsif activity_params[:end_date] == ""
      if @activity.image.attached? && @activity.update_attributes(capacity: activity_params[:capacity], contact_number: activity_params[:contact_number], contact_email: activity_params[:contact_email], activity_name: activity_params[:activity_name], content: activity_params[:content], additional_info: activity_params[:additional_info], user_id: current_user.id, start_date: activity_params[:start_date], end_date: @activity.end_date, picture: activity_params[:picture], addressLN1: activity_params[:addressLN1], addressLN2: activity_params[:addressLN2], city: activity_params[:city], state: activity_params[:state], cost: activity_params[:cost], zip: activity_params[:zip])
        redirect_to user_path(current_user)
      else
        flash.now[:error] = @activity.errors.full_messages.join(", ") + (@activity.errors.full_messages.length == 0 ? "please attach a picture" : ", please attach a picture")
        render "edit"
      end
    else
      if @activity.image.attached? && @activity.update_attributes(capacity: activity_params[:capacity], contact_number: activity_params[:contact_number], contact_email: activity_params[:contact_email], activity_name: activity_params[:activity_name], content: activity_params[:content], additional_info: activity_params[:additional_info], user_id: current_user.id, start_date: activity_params[:start_date], end_date: activity_params[:end_date], picture: activity_params[:picture], addressLN1: activity_params[:addressLN1], addressLN2: activity_params[:addressLN2], city: activity_params[:city], state: activity_params[:state], cost: activity_params[:cost], zip: activity_params[:zip])
        redirect_to user_path(current_user)
      else
        flash.now[:error] = @activity.errors.full_messages.join(", ") + (@activity.errors.full_messages.length == 0 ? "please attach a picture" : ", please attach a picture")
        render "edit"
      end
    end
  end

 def destroy
   @activity = current_user.activities.find(params[:id])
   @activity.destroy
   redirect_to user_path(current_user)
 end

  private
  def activity_params
    params.require(:activity).permit(:image, :account_number, :routing_number, :capacity, :contact_email, :contact_number, :activity_name, :content, :category, :additional_info, :cost, :start_date, :end_date, :picture, :addressLN1, :addressLN2, :city, :state, :zip, images: [])
  end

  def user_params
    params.require(:user).permit(:account_number, :routing_number)
  end
end
