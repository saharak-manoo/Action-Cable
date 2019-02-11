class PageController < ApplicationController
  def index
    ActionCable.server.broadcast 'web_notifications_channel', message: params[:messages], time: Time.now.strftime("%H:%M") if params[:messages]
  end
end
