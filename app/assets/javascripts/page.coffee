# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
App.room = App.cable.subscriptions.create "WebNotificationsChannel",
  received: (data) ->
    if data['typing'] == 'false'
      $('#typeMessages').hide();
      if data['sender_id'] == data['current_user']
        $('#messages-'+ data['recipient_id']).append messagesForm(data);
        $('#messages-'+ data['current_user']).append messagesTO(data);
    else
      $('#typeMessages').html(messagesTO(data));
      hideTypeing();
