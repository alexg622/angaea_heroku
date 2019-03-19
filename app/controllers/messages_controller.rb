class MessagesController < ApplicationController

  def create
    message = Message.new(message_params)
    message.user = current_user
    if message.save
      read_message = ReadMessage.new(user_id: message.user.id, message_id: message.id)
      if read_message.save
        ActionCable.server.broadcast 'messages',
          message: message.content,
          user: message.user.name,
          user_id: message.user.id
        head :ok
      end
    end
  end

  private

    def message_params
      params.require(:message).permit(:content, :chatroom_id)
    end
end
