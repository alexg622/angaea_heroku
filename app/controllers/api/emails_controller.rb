class Api::EmailsController < ApplicationController
  protect_from_forgery with: :null_session

  def send_contact_email_and_text
    @email = params[:email]
    @content = params[:text]

    if AngaeaActivationMailer.send_contact_email_to_ron(@email, @content).deliver
      render json: { success: true }, status: 200
    else
      render json: { success: false }, status: 500
    end
  end
end
