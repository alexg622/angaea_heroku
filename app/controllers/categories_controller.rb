class CategoriesController < ApplicationController
  helper_method :agreements_signed?


  def show
    @category = Category.find(params[:id])
    # fix later to make recurring at the front 
    @activities = @category.activities.sort_by {|activity| DateTime.now}.reverse
  end
end
