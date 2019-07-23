class ReloadActivesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "reload_actives_channel"
  end

  def unsubscribed
  end
end
