App.room = App.cable.subscriptions.create "ReloadActivesChannel",
  received: (data) ->
      if data.sessions == true
        reloadStatusOnSessions(data);
      else
        reloadStatusNotSessions(data);
