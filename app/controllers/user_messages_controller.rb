class UserMessagesController < ApplicationController
  def create
    message = UserMessage.new(message_params)
    message.user = current_user
    if message.save
      ActionCable.server.broadcast 'user_messages',
        message: message.content,
        user: message.user.name,
        user_id: message.user.id
      head :ok
    end
  end

  private

    def message_params
      params.require(:message).permit(:content, :chatroom_id)
    end
end
