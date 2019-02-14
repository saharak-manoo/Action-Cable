# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
App.room = App.cable.subscriptions.create "WebNotificationsChannel",
  received: (data) ->
    if data['typing'] == 'false'
      $('#typeMessages').hide();
      if data['sender_id'] == data['current_user']
        $('.chat-room-'+ data['recipient_id']).animate({ scrollTop: $(document).height() }, 'slow');
        $('.chat-room-'+ data['current_user']).animate({ scrollTop: $(document).height() }, 'slow');
        $('#messages-'+ data['recipient_id']).append messagesForm(data);
        $('#messages-'+ data['current_user']).append messagesTO(data);
    else
      $('.chat-room-'+ data['current_user']).animate({ scrollTop: $(document).height() }, 'slow');
      $('#typeMessages').html(messagesTO(data));
      hideTypeing();
