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
  end

  def change_chat
    chat_room = ChatRoom.find_by(sender_id: params[:sender_id], recipient_id: params[:recipient_id])
    messages = Message.where(room_id: chat_room&.room_id)
    ActionCable.server.broadcast 'reload_messages_channel',
                                  messages: chat_datas(messages),
                                  sender_id: params[:sender_id].to_i,
                                  recipient_id: params[:recipient_id],
                                  chat_with: chat_with(params[:recipient_id]),
                                  messages_count: messages.count
  end

  def chat_datas(messages)
    datas = []
    messages.each do |data|
      date_to_day = data&.created_at.strftime('%d').to_i >= DateTime.now.strftime('%d').to_i
      datas << {
        message: data&.messages,
        time: "#{data&.created_at&.strftime("%H:%M")}, #{date_to_day ? 'Today' : data&.created_at&.strftime('%d/%m/%Y')}",
        sender_id: data&.sender_id,
        recipient_id: data&.recipient_id,
        room_id: data&.room_id,
        photo: data&.message_as_sender&.photo
      }
    end

    return datas
  end

  def chat_with(id)
    user = User.find_by(id: id)
    datas = {
      full_name: user&.full_name,
      photo: user&.photo
    }

    return datas
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

