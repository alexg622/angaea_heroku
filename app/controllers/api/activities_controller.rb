class Api::ActivitiesController < ApplicationController
  protect_from_forgery with: :null_session
  
  def show
    @activity = Activity.find(params[:id])
  end

  def create
    @user = current_user

    @activity = Activity.new(recurring_schedule: activity_params[:recurring_schedule], capacity: activity_params[:capacity], contact_number: activity_params[:contact_number], contact_email: activity_params[:contact_email], activity_name: activity_params[:activity_name], content: activity_params[:content], additional_info: activity_params[:additional_info], user_id: current_user.id, start_date: activity_params[:start_date], end_date: activity_params[:end_date], addressLN1: activity_params[:addressLN1], addressLN2: activity_params[:addressLN2], city: activity_params[:city], state: activity_params[:state], cost: activity_params[:cost], zip: activity_params[:zip])
    @category = Category.find_by(category_name: activity_params[:category])
    if @activity.save
      if activity_params[:image]
        @activity.image.attach(activity_params[:image])
      end

      if activity_params[:images]
        @activity.images.attach(activity_params[:images])
      end

      @tag = Tag.new(activity_id: @activity.id, category_id: @category.id)
      if @tag.save
        render show
      end
    end
  end

  def update
    @activity = Activity.find(params[:id])
    if @activity.update(recurring_schedule: activity_params[:recurring_schedule], capacity: activity_params[:capacity], contact_number: activity_params[:contact_number], contact_email: activity_params[:contact_email], activity_name: activity_params[:activity_name], content: activity_params[:content], additional_info: activity_params[:additional_info], start_date: activity_params[:start_date], end_date: activity_params[:end_date], addressLN1: activity_params[:addressLN1], addressLN2: activity_params[:addressLN2], city: activity_params[:city], state: activity_params[:state], cost: activity_params[:cost], zip: activity_params[:zip])

      if activity_params[:image]
        @activity.image.attach(activity_params[:image])
      end

      if activity_params[:images]
        @activity.images.attach(activity_params[:images])
      end
      return render show, status: 200
    else
      return render json: {error: "Failed to update"}, status: 406
    end
  end

  private
  def activity_params
    params.require(:activity).permit(:recurring_schedule, :image, :capacity, :contact_email, :contact_number, :activity_name, :content, :category, :additional_info, :cost, :start_date, :end_date, :picture, :addressLN1, :addressLN2, :city, :state, :zip, images: [])
  end

end
