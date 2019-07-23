class ReloadNewFeedsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "reload_new_feeds_channel"
  end

  def unsubscribed
  end
end
