App.room = App.cable.subscriptions.create "ReloadActivesChannel",
  received: (data) ->
      reloadStatusOnSessions(data);
