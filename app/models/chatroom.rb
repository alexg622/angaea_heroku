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
