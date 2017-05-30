App.chatroom = App.cable.subscriptions.create "ChatroomChannel",
# Called when the subscription is ready for use on the server
  connected: ->
    console.log("connected")

# Called when the subscription has been terminated by the server
  disconnected: ->
    console.log("disconnected")

  received: (data) ->
    $('#chat-msg').append(data.content)
    console.log("received")
  
  send_comment: (msg) ->
    @perform 'send_comment', content: msg

$(document).on 'keypress', '#msg-input', (event) ->
  if event.keyCode is 13
    App.chatroom.send_comment(event.target.value)
    event.target.value = ""
    event.preventDefault()

