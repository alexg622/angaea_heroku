class StaticPagesController < ApplicationController
  before_action :agreements_signed?, only: [:home]
  
  def home
    @activities = Activity.categorize_activities
    @art_activities = @activities["art"][0..2]
    @dance_activities = @activities["dance"][0..2]
    @music_activities = @activities["music"][0..2]
    @art = Category.find_by(category_name: "art")
    @music = Category.find_by(category_name: "music")
    @dance = Category.find_by(category_name: "dance")
  end

  def terms_and_conditions
  end

  def show_terms_and_conditions
  end

  def show_privacy_agreement
  end

  def privacy_conditions
  end

  def create_terms_and_conditions
    @user = current_user
    if params[:user]
      if user_params[:agree_to_terms] == "true"
        p "in the true statement"
        @user.update_attributes(agree_to_terms: true) || @user.agree_to_terms == true
        return redirect_to "/privacyConditions"
      end
    else
      p "not in the true statement"
      render :terms_and_conditions
    end
  end

  def create_privacy_conditions
    @user = current_user
    if params[:user]
      if user_params[:agree_to_privacy] == "true"
        @user.update_attributes(agree_to_privacy: true) || @user.agree_to_privacy == true
        return redirect_to user_path(@user)
      end
    else
      render :privacy_conditions
    end
  end

  def about
  end

  def contact
  end

  private
  def user_params
    if params[:user]
      params.require(:user).permit(:agree_to_terms, :agree_to_privacy)
    end
  end

end
