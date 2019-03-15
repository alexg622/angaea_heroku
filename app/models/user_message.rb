class UserMessage < ApplicationRecord
  belongs_to :user
  belongs_to :user_chatroom
end
