class Message < ApplicationRecord
  belongs_to :message_as_sender, foreign_key: "sender_id", class_name: "User"
  belongs_to :message_as_recipient, foreign_key: "recipient_id", class_name: "User"
  belongs_to :chat_room, foreign_key: "room_id", class_name: "ChatRoom", required: false
end
