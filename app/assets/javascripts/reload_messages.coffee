App.room = App.cable.subscriptions.create "ReloadMessagesChannel",
  received: (data) ->
      if data.search == true
        $('.contacts-'+ data.sender_id).html(renderContactsList(data));
      else
        $('.contacts-'+ data.sender_id).html(renderContactsList(data));
        renderChats(data);
