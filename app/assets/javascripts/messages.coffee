# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
App.room = App.cable.subscriptions.create "WebNotificationsChannel",
  received: (data) ->
    if data['typing'] == 'false'
      $('#typeMessages').hide();
      if data.sender_id == data.current_user
        $('#messagesCount-'+data.current_user).html(data.messages_count+ "  Messages");
        $('#messagesCount-'+data.recipient_id).html(data.messages_count+ "  Messages");
        $('.chat-room-'+ data.recipient_id).animate({ scrollTop: $(document).height() }, 'slow');
        $('.chat-room-'+ data.current_user).animate({ scrollTop: $(document).height() }, 'slow');
        $('#messages-'+ data.recipient_id).append messagesForm(data.message, data.time, data.photo);
        $('#messages-'+ data.current_user).append messagesTO(data.message, data.time, data.photo);
    else
      $('#typeMessages').html(messagesTO(data.message, data.time, data.photo));
      hideTypeing();
