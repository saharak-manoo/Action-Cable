require 'rufus-scheduler'

scheduler = Rufus::Scheduler::singleton

scheduler.every '59s' do
  ActionCable.server.broadcast 'reload_actives_channel',
                                  new_sessions: users,
                                  sessions: false
end

def users
  datas = []

  User.all.each do |user|
    datas << {
      id: user&.id,
      full_name: user&.full_name,
      photo: user&.photo,
      online: user&.online?,
      offline_time: user&.offline_time?
    }
  end

  return datas
end
