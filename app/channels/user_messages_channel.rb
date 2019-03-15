class UserMessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'user_messages'
  end
end
