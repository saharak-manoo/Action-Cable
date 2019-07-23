class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def broadcast_now
    ActionCable.server.broadcast 'reload_actives_channel',
                                  new_sessions: chat_with(current_user&.id),
                                  sessions: true
  end

  def chat_with(id)
    user = User.find_by(id: id)
    datas = {
      id: user&.id,
      full_name: user&.full_name,
      photo: user&.photo,
      online: user&.online?,
      offline_time: user&.offline_time?
    }

    return datas
  end
end
