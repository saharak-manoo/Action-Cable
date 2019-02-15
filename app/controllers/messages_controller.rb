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
                      sender_id: params[:sender_id].to_i,
                      recipient_id: params[:recipient_id].to_i,
                      current_user: current_user&.id.to_i
    else
      create_message
    end
  end

  def create_message
    chat_room = ChatRoom.find_by(sender_id: params[:sender_id], recipient_id: params[:recipient_id])
    if chat_room.nil?
      room_id = create_chat_rooms
    else
      room_id = chat_room&.room_id
    end

    message = Message.new(message_params.merge(room_id: room_id))
    if message.save
      ActionCable.server.broadcast 'web_notifications_channel',
                      message: message&.messages,
                      time: "#{message&.created_at&.strftime("%H:%M")}, Today",
                      typing: params[:typing],
                      photo: params[:photo],
                      sender_id: params[:sender_id].to_i,
                      recipient_id: params[:recipient_id].to_i,
                      current_user: current_user&.id.to_i,
                      messages_count: Message.where(room_id: room_id).count,
                      contacts_list: contacts_list(User.where.not(id: current_user&.id).joins(:message_as_recipient).order('messages.created_at desc')&.uniq)
    end

    change_chat if params[:temp_message].to_i >= 14
  end

  def create_chat_rooms
    chat_room_id = ((ChatRoom&.last&.room_id&.to_i) || 0) + 1
    chat_room = ChatRoom.create!(sender_id: params[:sender_id], recipient_id: params[:recipient_id], room_id: chat_room_id)
    chat_room = ChatRoom.create!(sender_id: params[:recipient_id], recipient_id: params[:sender_id], room_id: chat_room_id)

    return chat_room&.room_id
  end

  def change_chat
    chat_room = ChatRoom.find_by(sender_id: params[:sender_id], recipient_id: params[:recipient_id])
    messages = Message.where(room_id: chat_room&.room_id).order(created_at: :desc).limit(params[:count_message].present? ? params[:count_message].to_i : 10)
    users = User.where.not(id: current_user&.id).joins(:message_as_recipient).order('messages.created_at desc')&.uniq
    if users.empty?
      users = User.where.not(id: current_user&.id)
    end
    ActionCable.server.broadcast 'reload_messages_channel',
                                  messages: chat_datas(messages),
                                  sender_id: params[:sender_id].to_i,
                                  recipient_id: params[:recipient_id].to_i,
                                  chat_with: chat_with(params[:recipient_id]),
                                  messages_count: Message.where(room_id: chat_room&.room_id).count,
                                  contacts_list: contacts_list(users),
                                  count_message: params[:count_message].present?
  end

  def chat_datas(messages)
    datas = []
    messages.each do |data|
      date_to_day = data&.created_at.strftime('%d').to_i >= DateTime.now.strftime('%d').to_i
      datas << {
        id: data&.id,
        message: data&.messages,
        time: "#{data&.created_at&.strftime("%H:%M")}, #{date_to_day ? 'Today' : data&.created_at&.strftime('%d/%m/%Y')}",
        sender_id: data&.sender_id,
        recipient_id: data&.recipient_id,
        room_id: data&.room_id,
        photo: data&.message_as_sender&.photo
      }
    end

    return datas.sort {|x, y| x[:id] <=> y[:id]}
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
    @users = User.where.not(id: current_user&.id).joins(:message_as_recipient).order('messages.created_at desc')&.uniq
    if @users.empty?
      @users = User.where.not(id: current_user&.id)
    end
    @recipient = User.find_by(id: @users&.first&.id)
    @chat_room = ChatRoom.find_by(sender_id: current_user&.id, recipient_id: @recipient&.id)
    @messages_total = Message.where(room_id: @chat_room&.room_id)
    @messages = Message.where(room_id: @chat_room&.room_id).order(created_at: :desc).limit(10)
  end

  def search
    users = User.where.not(id: current_user&.id)
    search = params[:search]

    if search.present?
      params_split = search.split(' ').compact
      first_query = (params_split.count > 1 ? params_split[0...-1] : params_split).join(' ')
      last_query = params_split.last
      users = users.where("first_name LIKE :search or
                          last_name LIKE :search or
                          (first_name LIKE :first_query and
                          last_name LIKE :last_query)",
                          first_query: "%#{first_query}%",
                          last_query: "%#{last_query}%",
                          search: "%#{params[:search]}%")
    end

    users = contacts_list(users)

    ActionCable.server.broadcast 'reload_messages_channel',
                                  contacts_list: users,
                                  sender_id: params[:sender_id].to_i,
                                  recipient_id: params[:recipient_id].to_i,
                                  search: true
  end

  def contacts_list(users)
    datas = []
    users.each do |user|
      datas << {
        id: user&.id,
        full_name: user&.full_name,
        photo: user&.photo
      }
    end

    return datas
  end

  def message_params
    params.permit(:messages, :sender_id, :recipient_id)
  end
end

