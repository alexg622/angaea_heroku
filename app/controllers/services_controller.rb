class ServicesController < ApplicationController
  before_action :agreements_signed?
  before_action :activity_no_stripe, only: [:new, :create]

  def show
    @service = Service.find(params[:id])
    @tags = @service.categories
  end

end
