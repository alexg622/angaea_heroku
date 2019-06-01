class Api::EmailsController < ApplicationController
  protect_from_forgery with: :null_session

  def send_contact_email_and_text
    @email = params[:email]
    @content = params[:text]
    
    client = Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
    client.messages.create(
      from: ENV["TWILIO_NUMBER"],
      to: "1415-909-0164",
      body: @content
    )

    if AngaeaActivationMailer.send_contact_email_to_ron(@email, @content).deliver
      render json: { success: true }, status: 200
    else
      render json: { success: false }, status: 500
    end
  end
end
