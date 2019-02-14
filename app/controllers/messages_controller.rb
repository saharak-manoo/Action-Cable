class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    photo = ['https://devilsworkshop.org/files/2013/01/enlarged-facebook-profile-picture.jpg', 'http://profilepicturesdp.com/wp-content/uploads/2018/07/sweet-girl-profile-pictures-9.jpg', 'https://devilsworkshop.org/files/2013/01/enlarged-facebook-profile-picture.jpg']
    @photo = photo[current_user&.id]
    id = current_user&.id.to_i - 1
    @photo_you = photo[id]
    @recipient = User.where.not(id: current_user&.id).first
    @messages = Message.all
  end

  def chat
    if params[:typing] == 'true'
      ActionCable.server.broadcast 'web_notifications_channel',
                      message: params[:messages],
                      time: Time.now.strftime("%H:%M"),
                      typing: params[:typing],
                      photo: params[:photo],
                      sender_id: params[:sender_id],
                      recipient_id: params[:recipient_id],
                      current_user: current_user&.id.to_s
    else
      create_message
    end
  end

  def create_message
    message = Message.new(message_params)
    if message.save
      ActionCable.server.broadcast 'web_notifications_channel',
                      message: message&.messages,
                      time: message&.created_at&.strftime("%H:%M"),
                      typing: params[:typing],
                      photo: params[:photo],
                      sender_id: params[:sender_id],
                      recipient_id: params[:recipient_id],
                      current_user: current_user&.id.to_s
    end
  end

  def message_params
    params.permit(:messages, :sender_id, :recipient_id)
  end
end

