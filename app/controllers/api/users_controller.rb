class Api::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    # @jwt = "test"
  end

end
