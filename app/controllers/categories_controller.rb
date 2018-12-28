class CategoriesController < ApplicationController
  helper_method :agreements_signed?


  def show
    @category = Category.find(params[:id])
    @activities = @category.activities
  end
end
