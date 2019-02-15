# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
App.room = App.cable.subscriptions.create "WebNotificationsChannel",
  received: (data) ->
    if data.typing == 'false'
      $('#typeMessages').hide();
      pushMessage(data);
      $('.contacts-'+ data.sender_id).html(renderContactsList(data));
    else
      $('#typeMessages').html(messagesTO(data.message, data.time, data.photo));
      hideTypeing();
