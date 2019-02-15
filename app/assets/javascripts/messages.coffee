# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
App.room = App.cable.subscriptions.create "WebNotificationsChannel",
  received: (data) ->
      pushMessage(data);
      $('.contacts-'+ data.sender_id).html(renderContactsList(data));
      $('.contacts_body-'+ data.sender_id).animate({ scrollTop: 0 }, 'slow');
