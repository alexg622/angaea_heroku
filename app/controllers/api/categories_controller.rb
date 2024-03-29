class Api::CategoriesController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    @categories = Category.sort_categories
    render "index"
  end

  def show
    # @category = Category.find(3)
    @category = Category.find(params[:id])
    # fix later to make recurring at the front
    @activities = @category.activities.sort_by {|activity| DateTime.now}.reverse
  end
end
