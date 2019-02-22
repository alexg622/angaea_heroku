class CategoriesController < ApplicationController
  helper_method :agreements_signed?

  def index
    @categories = Category.sort_categories
  end

  def show
    # @category = Category.find(3)
    @category = Category.find(params[:id])
    # fix later to make recurring at the front
    @activities = @category.activities.sort_by {|activity| DateTime.now}.reverse
  end

  def services_index
    @categories = Category.sort_categories
  end

  def show_services
    @category = Category.find(params[:id])
    @services = @category.services 
  end

  def show_testing
    @category = Category.find(params[:id])
    # @category = Category.find(params[:id])
    # fix later to make recurring at the front
    @activities = @category.activities.sort_by {|activity| DateTime.now}.reverse
    render "show"
  end
end
