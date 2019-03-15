App.userMessages = App.cable.subscriptions.create('UserMessagesChannel', {
  received: function(data) {
    // document.querySelector("#messages").classList.remove('hidden')
    return document.querySelector('.lower-right-container').innerHTML = this.renderMessage(data) + document.querySelector('.lower-right-container').innerHTML;
  },

  renderMessage: function(data) {
    return "<div><p class='message-p'><a class='change-href user-activity-message' href=''>" + data.user + ":</a>" + " " + data.message + "</p><div style='display:none;' class='get-user-id'>"+ data.user_id +"</div></div>";
  }
});
