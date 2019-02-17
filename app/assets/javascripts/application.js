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

function renderChat(data, reverse) {
  html = '<div class="load-bar more-messages hide"><div class="bar"></div><div class="bar"></div><div class="bar"></div></div><br>';
  $.each(data.messages, function (index) {
    if (data.messages[index].recipient_id == data.sender_id) {
      if (reverse == true) {
        html += messagesForm(data.messages[index].message, data.messages[index].time, data.messages[index].photo)
      } else {
        html += messagesTO(data.messages[index].message, data.messages[index].time, data.messages[index].photo)
      }
    } else {
      if (reverse == true) {
        html += messagesTO(data.messages[index].message, data.messages[index].time, data.messages[index].photo)
      } else {
        html += messagesForm(data.messages[index].message, data.messages[index].time, data.messages[index].photo)
      }
    }
  })
  if (reverse == true) {
    html += '<div class="showMessages messages-'+ data.sender_id +'and-'+ data.recipient_id +'"></div>'
  } else {
    html += '<div class="showMessages messages-'+ data.recipient_id +'and-'+ data.sender_id +'"></div>'
  }

  html += '<div class="type-messages-'+ data.sender_id +' hide"> <div class="d-flex justify-content-end mb-4"> <div class="msg_cotainer_send"> กำลังพิมพ์... <span class="msg_time_send">Now, Today</span> </div> <div class="img_cont_msg"> <img src="'+ data.photo +'" class="rounded-circle user_img_msg"> </div> </div> </div>'
  return html;
}

function pushMessage(data) {
  let recipient = data.recipient_id +'and-'+ data.sender_id
  let sender = data.sender_id +'and-'+ data.recipient_id
  $('.messagesCount-'+ sender).html(data.messages_count + '  Messages : <span class="onlineText-'+ data.recipient_id +'">'+ data.chat_with.offline_time+'<span>');
  $('.messagesCount-'+ recipient).html(data.messages_count + '  Messages : <span class="onlineText-'+ data.recipient_id +'">'+ data.chat_with.offline_time+'<span>');
  $('.messages-'+ recipient).append(messagesForm(data.message, data.time, data.photo));
  $('.messages-'+ sender).append(messagesTO(data.message, data.time, data.photo));
  $('.chat-room-'+ recipient).animate({ scrollTop: $(document).height() }, 'slow');
  $('.chat-room-'+ sender).animate({ scrollTop: $(document).height() }, 'slow');
}

function renderChats(data) {
  let recipient = data.recipient_id +'and-'+ data.sender_id
  let sender = data.sender_id +'and-'+ data.recipient_id
  $('.chatWithPhoto-'+ sender).attr('src', data.chat_with.photo);
  $('.chatWithName-'+ sender).html('Chat with '+ data.chat_with.full_name);
  $('.messagesCount-'+ sender).html(data.messages_count + '  Messages : <span class="onlineText-'+ data.recipient_id +'">'+ data.chat_with.offline_time+'<span>');
  if (data.chat_with.online == true) {
    $('.online-'+ sender).removeClass('offline');
  } else {
    $('.online-'+ sender).addClass('offline');
  }
  $('.chat-room-'+ sender).html(renderChat(data, true));
  if (data.count_message != true) {
    $('.chat-room-'+ sender).animate({ scrollTop: $(document).height() }, 'slow');
  }
  $('.chat-room-'+ recipient).html(renderChat(data, false));
  $('.chat-room-'+ recipient).animate({ scrollTop: $(document).height() }, 'slow');
}

function renderContactsList(data) {
  html = '';
  $.each(data.contacts_list, function (index) {
    active = (data.contacts_list[index].id == data.recipient_id ? "active" : "");
    offline = (data.contacts_list[index].online ? "" : "offline");
    userIndex = "'user-"+ index +"'";
    contactsList = "'"+ data.contacts_list[index].id +"'"
    html += '<li class="contact '+ active +'" id="user-'+ index +'">'+
              '<div class="d-flex bd-highlight" onclick="showChat('+ userIndex +', '+ contactsList +')">'+
                '<div class="img_cont">'+
                  '<img src="'+ data.contacts_list[index].photo +'" class="rounded-circle user_img">'+
                  '<span class="online_icon '+ offline +'"></span>'+
                '</div>'+
                '<div class="user_info">'+
                  '<span>'+ data.contacts_list[index].full_name +'</span>'+
                  '<p class="onlineText-'+ data.contacts_list[index].id +'">'+ data.contacts_list[index].offline_time +'</p>'+
                '</div>'+
              '</div>'+
            '</li>'
  })

  return html;
}

function reloadStatusOnSessions(data) {
  if (data.new_sessions.online == true) {
    $('.onlineStatus-'+ data.new_sessions.id).removeClass('offline');
  } else {
    $('.onlineStatus-'+ data.new_sessions.id).addClass('offline');
  }
  $('.onlineText-'+ data.new_sessions.id).text(data.new_sessions.offline_time);
}

function reloadStatusNotSessions(data) {
  $.each(data.new_sessions, function (index) {
    if (data.new_sessions[index].online == true) {
      $('.onlineStatus-'+ data.new_sessions[index].id).removeClass('offline');
    } else {
      $('.onlineStatus-'+ data.new_sessions[index].id).addClass('offline');
    }
    $('.onlineText-'+ data.new_sessions[index].id).text(data.new_sessions[index].offline_time);
  });
}

function showNotification(data) {
  $('.noti-to-'+ data.recipient_id).html(renderNotification(data));
  setTimeout(function(){ $('.Message').hide(); }, 2000);
}

function renderNotification(data) {
  html = '<ul class="noti">'+
            '<li class="noti">'+
              '<div class="Message Message-light">'+
                '<div class="Message-icon">'+
                  '<img src="'+ data.photo +'" class="rounded-circle user_img_msg_noti">'+
                '</div>'+
                '<div class="Message-body">'+
                  '<p>'+ data.message +'</p>'+
                '</div>'+
              '</div>'+
            '</li>'+
          '</ul>'

  return html;
}
