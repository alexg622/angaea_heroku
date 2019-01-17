class RentalsController < ApplicationController
  before_action :agreements_signed?


  def index
    @rentals = Rental.all
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def create
    @rental = Rental.new(cost: rental_params[:cost], rental_name: rental_params[:rental_name], description: rental_params[:description], category: rental_params[:category], additional_info: rental_params[:additional_info], contact_number: rental_params[:contact_number], contact_email: rental_params[:contact_email], addressLN2: rental_params[:addressLN2], addressLN1: rental_params[:addressLN1], state: rental_params[:state], city: rental_params[:city], zipcode: rental_params[:zipcode], start_date: rental_params[:start_date], end_date: rental_params[:end_date])
    @rental.user = current_user
    @user = current_user
    if @rental.save && @user.update_attributes(account_number: user_params[:account_number], routing_number: user_params[:routing_number])
      if rental_params[:image]
        @rental.image.attach(rental_params[:image])
      end
      if rental_params[:images]
        @rental.images.attach(rental_params[:images])
      end
      redirect_to user_path(current_user)
    else
      redirect_to user_path(current_user), :flash => { :error => @rental.errors.full_messages.join(", ") }
    end
  end

  def edit
    @rental = current_user.rentals.find(params[:id])
  end

  def update
    @rental = current_user.rentals.find(params[:id])
    if rental_params[:image]
      @rental.image.attach(rental_params[:image])
    end

    if rental_params[:images]
      @rental.images.attach(rental_params[:images])
    end
    
    if rental_params[:end_date] == "" && rental_params[:start_date] == ""
      if @rental.update_attributes(cost: rental_params[:cost], rental_name: rental_params[:rental_name], description: rental_params[:description], additional_info: rental_params[:additional_info], contact_number: rental_params[:contact_number], contact_email: rental_params[:contact_email], addressLN2: rental_params[:addressLN2], addressLN1: rental_params[:addressLN1], state: rental_params[:state], city: rental_params[:city], zipcode: rental_params[:zipcode], start_date: @rental.start_date, end_date: @rental.end_date) && @rental.image.attached?
        redirect_to user_path(current_user)
      else
        flash.now[:error] = @rental.errors.full_messages.join(", ") + (@rental.errors.full_messages.length == 0 ? "please attach a picture" : ", please attach a picture")
        render "edit"
      end
    elsif rental_params[:end_date] == ""
      if @rental.update_attributes(cost: rental_params[:cost], rental_name: rental_params[:rental_name], description: rental_params[:description], additional_info: rental_params[:additional_info], contact_number: rental_params[:contact_number], contact_email: rental_params[:contact_email], addressLN2: rental_params[:addressLN2], addressLN1: rental_params[:addressLN1], state: rental_params[:state], city: rental_params[:city], zipcode: rental_params[:zipcode], start_date: rental_params[:start_date], end_date: @rental.end_date) && @rental.image.attached?
        redirect_to user_path(current_user)
      else
        flash.now[:error] = @rental.errors.full_messages.join(", ") + (@rental.errors.full_messages.length == 0 ? "please attach a picture" : ", please attach a picture")
        render "edit"
      end
    elsif rental_params[:start_date] == ""
      if @rental.update_attributes(cost: rental_params[:cost], rental_name: rental_params[:rental_name], description: rental_params[:description], additional_info: rental_params[:additional_info], contact_number: rental_params[:contact_number], contact_email: rental_params[:contact_email], addressLN2: rental_params[:addressLN2], addressLN1: rental_params[:addressLN1], state: rental_params[:state], city: rental_params[:city], zipcode: rental_params[:zipcode], start_date: @rental.start_date, end_date: rental_params[:end_date]) && @rental.image.attached?
        redirect_to user_path(current_user)
      else
        flash.now[:error] = @rental.errors.full_messages.join(", ") + (@rental.errors.full_messages.length == 0 ? "please attach a picture" : ", please attach a picture")
        render "edit"
      end
    else
      if @rental.update_attributes(rental_params) && @rental.image.attached?
        redirect_to user_path(current_user)
      else
        flash.now[:error] = @rental.errors.full_messages.join(", ") + (@rental.errors.full_messages.length == 0 ? "please attach a picture" : ", please attach a picture")
        render "edit"
      end
    end
  end

  def destroy
    @rental = current_user.rentals.find(params[:id])
    @rental.destroy
    redirect_to user_path(current_user)
  end

  private
  def rental_params
    params.require(:rental).permit(:cost, :image, :rental_name, :description, :category, :additional_info, :contact_number, :contact_email, :addressLN2, :addressLN1, :state, :city, :zipcode, :start_date, :end_date, images: [])
  end

  def user_params
    params.require(:user).permit(:account_number, :routing_number)
  end
end
