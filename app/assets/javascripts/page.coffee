# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
App.room = App.cable.subscriptions.create "WebNotificationsChannel",
  received: (data) ->
    if data['typing'] == 'false'
      $('#typeMessages').hide();
      if data['actions'] == 'from'
        $('#messages').append messagesForm(data);
        $('#messagesFrom').append messagesTO(data);
      else
        $('#messagesFrom').append messagesForm(data);
        $('#messages').append messagesTO(data);
    else
      $('#typeMessages').html(messagesTO(data));
      hideTypeing();
