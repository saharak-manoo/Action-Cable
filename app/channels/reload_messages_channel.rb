class ReloadMessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "reload_messages_channel"
  end

  def unsubscribed
  end
end
