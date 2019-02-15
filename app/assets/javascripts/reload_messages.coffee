App.room = App.cable.subscriptions.create "ReloadMessagesChannel",
  received: (data) ->
    $('.chat-room-'+ data.sender_id).html(renderChat(data))
    $('.chat-room-'+ data.sender_id).animate({ scrollTop: $(document).height() }, 'slow');
    $('#chatWithPhoto-'+data.sender_id).attr('src', data.chat_with.photo);
    $('#chatWithName-'+data.sender_id).html("Chat with "+ data.chat_with.full_name);
    $('#messagesCount-'+data.sender_id).html(data.messages_count+ "  Messages");
