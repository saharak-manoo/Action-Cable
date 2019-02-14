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

function messagesTO(data) {
  html = '<div class="d-flex justify-content-end mb-4">'+
          '<div class="msg_cotainer_send" id="text">'+ data['message'] +'<span class="msg_time_send">'+ data['time'] +'</span> </div>'+
          '<div class="img_cont_msg"> <img src="'+ data['photo'] +'"'+
          'class="rounded-circle user_img_msg"> </div></div>'
  return html;
}

function messagesForm(data) {
  html = '<div class="d-flex justify-content-start mb-4">'+
          '<div class="img_cont_msg"> <img src="'+ data['photo'] +'" '+
          'class="rounded-circle user_img_msg"> </div> <div class="msg_cotainer">'+
          ''+ data['message'] +' <span class="msg_time">'+ data['time'] +'</span> </div> </div>'
  return html;
}

function hideTypeing() {
  setTimeout(function(){ $('#typeMessages').hide(); }, 600);
}
