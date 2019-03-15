class UserChatroom < ApplicationRecord
  has_many :connect_users
  has_many :users,
    through: :connect_users,
    source: :user
  has_many :user_messages
end
