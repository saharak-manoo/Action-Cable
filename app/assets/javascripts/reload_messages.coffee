App.room = App.cable.subscriptions.create "ReloadMessagesChannel",
  received: (data) ->
      renderChats(data);
