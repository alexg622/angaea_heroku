class ConnectUser < ApplicationRecord
  belongs_to :user
  belongs_to :user_chatroom 
end
