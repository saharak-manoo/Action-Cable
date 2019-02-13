class PagesController < ApplicationController
  def index
    ActionCable.server.broadcast 'web_notifications_channel',
                    message: params[:messages],
                    time: Time.now.strftime("%H:%M"),
                    typing: params[:typing],
                    photo: params[:photo],
                    actions: params[:actions] if params[:messages] && params[:typing] && params[:photo]
  end

  def chat
  end
end
