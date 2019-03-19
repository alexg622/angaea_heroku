class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages
  belongs_to :activity
  validates :topic, presence: true
  before_validation :sanitize, :slugify


  def to_param
    self.slug
  end

  def slugify
    self.slug = self.topic.downcase.gsub(" ", "-")
  end

  def sanitize
    self.topic = self.topic.strip
  end

  def user_unread_messages(user)
    user_read_messages = {}
    result = 0
    user.read_messages.each do |message|
      user_read_messages[message.message_id.to_s] = true
    end
    self.messages.each do |message|
      if !user_read_messages[message.id.to_s]
        result += 1
      end
    end
    result
  end

  def create_read_messages(user)
    user_messages = {}
    user.read_messages.each do |message|
      user_messages[message.message_id.to_s] = true
    end
    self.messages.each do |message|
      if !user_messages[message.id.to_s]
        ReadMessage.create(user_id: user.id, message_id: message.id)
      end
    end
  end

  def returnMessages
    messages = []
    self.messages.each do |message|
      mHash = {
        user: message.user.name,
        content: message.content,
        messageId: message.id,
        userId: message.user.id
      }
      messages.push(mHash)
    end
    return messages
  end
end
