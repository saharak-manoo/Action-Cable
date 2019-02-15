class User < ApplicationRecord
  has_many :message_as_sender, foreign_key: "sender_id", class_name: "Message"
  has_many :message_as_recipient, foreign_key: "recipient_id", class_name: "Message"
  has_many :chat_room_as_sender, foreign_key: "sender_id", class_name: "ChatRoom"
  has_many :chat_room_as_recipient, foreign_key: "recipient_id", class_name: "ChatRoom"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    return "#{self.first_name} #{self.last_name}"
  end
end
