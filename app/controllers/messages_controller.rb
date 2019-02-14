class MessagesController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :xlsx, :js, :json

  def index
    load_data
  end

  def chat
    if params[:typing] == 'true'
      ActionCable.server.broadcast 'web_notifications_channel',
                      message: params[:messages],
                      time: "#{Time.now.strftime("%H:%M")}, Today",
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
                      time: "#{message&.created_at&.strftime("%H:%M")}, Today",
                      typing: params[:typing],
                      photo: params[:photo],
                      sender_id: params[:sender_id],
                      recipient_id: params[:recipient_id],
                      current_user: current_user&.id.to_s,
                      messages_count: Message.where(sender_id: [params[:sender_id], params[:recipient_id]]).count
    end
    # if params[:temp_message].to_i >= 4
    #   load_data
    #   @messages = Message.all
    #   ActionCable.server.broadcast 'reload_messages_channel',
    #                   messages: @messages,
    #                   sender_id: params[:sender_id],
    #                   recipient_id: params[:recipient_id],
    #                   photo: @photo,
    #                   photo_you: @photo_you
    # end
  end

  def change_chat
    load_data
    @messages = Message.all
    ActionCable.server.broadcast 'reload_messages_channel',
                      messages: @messages,
                      sender_id: params[:sender_id],
                      recipient_id: params[:recipient_id],
                      photo: @photo,
                      photo_you: @photo_you
  end

  def load_data
    @users = User.where.not(id: current_user&.id)
    @recipient = User.find_by(id: @users&.first&.id)
    @chat_room = ChatRoom.find_by(sender_id: current_user&.id, recipient_id: @recipient&.id)
    @messages = Message.where(room_id: @chat_room&.room_id)
  end

  def message_params
    params.permit(:messages, :sender_id, :recipient_id, :room_id)
  end
end

