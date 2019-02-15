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

  def online?
    return self.current_sign_in_at >= self.last_sign_in_at
  end

  def offline_time?
    unless self.online?
      seconds_diff = (self.last_sign_in_at - DateTime.now).to_i.abs

      hours = seconds_diff / 3600
      seconds_diff -= hours * 3600

      minutes = seconds_diff / 60
      seconds_diff -= minutes * 60

      seconds = seconds_diff

      if hours == 0 && minutes == 0
        offline_time = "Active a few seconds"
      elsif hours == 0 && minutes != 0
        offline_time = "Active #{minutes}m ago"
      else
        offline_time = "Active #{hours}h ago"
      end
    else
      offline_time = "Active now"
    end

    return offline_time
  end
end
