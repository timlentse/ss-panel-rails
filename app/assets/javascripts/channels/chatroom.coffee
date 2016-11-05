App.chatroom = App.cable.subscriptions.create "ChatroomChannel",
  connected: ->
# Called when the subscription is ready for use on the server

  disconnected: ->
# Called when the subscription has been terminated by the server

  received: (data) ->
    $('#chat-msg').append(data.content)
  
  send_comment: (msg) ->
    @perform 'send_comment', content: msg

$(document).on 'keypress', '#msg-input', (event) ->
  if event.keyCode is 13
    App.chatroom.send_comment(event.target.value)
    event.target.value = ""
    event.preventDefault()

