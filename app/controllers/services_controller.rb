class ServicesController < ApplicationController
  before_action :agreements_signed?
  before_action :activity_no_stripe, only: [:new, :create]


  def show
    @service = Service.find(params[:id])
    @tags = @service.categories
  end

  def create
    @user = current_user

    @service = Service.new(availability_hours: service_params[:availability_hours], travel_options: service_params[:travel_options], availability_days: service_params[:availability_days], recurring_schedule: service_params[:recurring_schedule], capacity: service_params[:capacity], contact_number: service_params[:contact_number], contact_email: service_params[:contact_email], service_name: service_params[:service_name], content: service_params[:content], additional_info: service_params[:additional_info], user_id: current_user.id, start_date: service_params[:start_date], end_date: service_params[:end_date], addressLN1: service_params[:addressLN1], addressLN2: service_params[:addressLN2], city: service_params[:city], state: service_params[:state], cost: service_params[:cost], zip: service_params[:zip])
    @category = Category.find_by(category_name: service_params[:category])
    if @service.save #&& @user.update_attributes(account_number: user_params[:account_number], routing_number: user_params[:routing_number])
      # @service.image.attach(service_params[:image])
      if service_params[:image]
        @service.image.attach(service_params[:image])
      end

      if service_params[:images]
        @service.images.attach(service_params[:images])
      end

      @tag = ServiceTag.new(service_id: @service.id, category_id: @category.id)
      if @tag.save
        redirect_to user_path(current_user)
      end
    else
      @user = current_user
      redirect_to user_path(current_user), :flash => { :error => @service.errors.full_messages.join(", ") }
    end
  end

  def edit
    @service = Service.find(params[:id])
  end

  def update
    @service = current_user.services.find(params[:id])
    if service_params[:image]
      @service.image.attach(service_params[:image])
    end

    if service_params[:images]
      @service.images.attach(service_params[:images])
    end

    if @service.image.attached? && @service.update_attributes(availability_hours: service_params[:availability_hours], travel_options: service_params[:travel_options], availability_days: service_params[:availability_days], recurring_schedule: service_params[:recurring_schedule], capacity: service_params[:capacity], contact_number: service_params[:contact_number], contact_email: service_params[:contact_email], service_name: service_params[:service_name], content: service_params[:content], additional_info: service_params[:additional_info], user_id: current_user.id, start_date: service_params[:start_date], end_date: service_params[:end_date], addressLN1: service_params[:addressLN1], addressLN2: service_params[:addressLN2], city: service_params[:city], state: service_params[:state], cost: service_params[:cost], zip: service_params[:zip])
      redirect_to user_path(current_user)
    else
      flash.now[:error] = @service.errors.full_messages.join(", ") + (@service.errors.full_messages.length == 0 ? "please attach a picture" : ", please attach a picture")
      render "edit"
    end
  end

 def destroy
   @service = current_user.services.find(params[:id])
   @service.destroy
   redirect_to user_path(current_user)
 end

  private
  def service_params
    params.require(:service).permit(:availability_hours, :travel_options, :recurring_schedule, :availability_days, :image, :capacity, :contact_email, :contact_number, :service_name, :content, :category, :additional_info, :cost, :start_date, :end_date, :picture, :addressLN1, :addressLN2, :city, :state, :zip, images: [])
  end
end
