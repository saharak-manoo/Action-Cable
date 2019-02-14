App.room = App.cable.subscriptions.create "ReloadMessagesChannel",
  received: (data) ->
    $('.msg_card_body').html(renderChat(data))
