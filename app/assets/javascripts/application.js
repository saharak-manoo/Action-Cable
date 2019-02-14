// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require turbolinks
//= require_tree .

function messagesTO(message, time, photo) {
  html = '<div class="d-flex justify-content-end mb-4">'+
          '<div class="msg_cotainer_send" id="text">'+ message +'<span class="msg_time_send">'+ time +'</span> </div>'+
          '<div class="img_cont_msg"> <img src="'+ photo +'"'+
          'class="rounded-circle user_img_msg"> </div></div>'
  return html;
}

function messagesForm(message, time, photo) {
  html = '<div class="d-flex justify-content-start mb-4">'+
          '<div class="img_cont_msg"> <img src="'+ photo +'" '+
          'class="rounded-circle user_img_msg"> </div> <div class="msg_cotainer">'+
          ''+ message +' <span class="msg_time">'+ time +'</span> </div> </div>'
  return html;
}

function hideTypeing() {
  setTimeout(function(){ $('#typeMessages').hide(); }, 600);
}

function renderChat(data) {
  html = '';
  temp_message = 0;
  $.each(data.messages, function (index) {
    if (data.messages[index].recipient_id == data.sender_id) {
      html += messagesTO(data.messages[index].messages, 'ddddd', data.photo)
    } else {
      html +=   messagesForm(data.messages[index].messages, 'ddddd', data.photo_you)
    }
  })
  html += '<div id="messages-'+ data.sender_id +'"></div><div id="typeMessages"></div>'
  return html;
//   <% @messages.each do |message| %>
//   <% date_to_day = message&.created_at.strftime('%d').to_i >= DateTime.now.strftime('%d').to_i %>
//   <% if message.recipient_id == current_user&.id %>
//     <div class="d-flex justify-content-start mb-4">
//       <div class="img_cont_msg">
//         <img src="<%= @photo %>" class="rounded-circle user_img_msg">
//       </div>
//       <div class="msg_cotainer">
//         <%= message&.messages %>
//         <span class="msg_time"><%= message&.created_at&.strftime("%H:%M") %>, <%= date_to_day ? 'Today' : message&.created_at&.strftime('%d/%m/%Y') %></span>
//       </div>
//     </div>
//   <% else %>
//     <div class="d-flex justify-content-end mb-4">
//       <div class="msg_cotainer_send">
//         <%= message&.messages %>
//         <span class="msg_time_send"><%= message&.created_at&.strftime("%H:%M") %>, <%= date_to_day ? 'Today' : message&.created_at&.strftime('%d/%m/%Y') %></span>
//       </div>
//       <div class="img_cont_msg">
//       <img src="<%= @photo_you %>" class="rounded-circle user_img_msg">
//       </div>
//     </div>
//   <% end %>
// <% end %>


}
