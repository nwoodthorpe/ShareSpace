# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@App = {}
App.cable = ActionCable.createConsumer('cable')

window.lastMessage = false

jQuery(document).on 'turbolinks:load', ->
  messages = $('#message-container')
  messages_loading = $('#message-container-loading')
  container = $('#messages-container');

  if $('#message-container').length > 0
    App.global_chat = App.cable.subscriptions.create {
        channel: "RoomsChannel"
        room_id: messages.data('room-id')
      },
      connected: ->
        # Called when the subscription is ready for use on the server
        console.log('We are now connected')
        messages.show()
        messages_loading.hide()

        container.scrollTop(container.prop("scrollHeight"));

      disconnected: ->
        # Called when the subscription has been terminated by the server
        console.log('We are now disconnected')

      received: (data) ->
        self_id = messages.data('user-id')

        last_message = messages[0].lastElementChild

        div = document.createElement('div');
        div.innerHTML = data["message"];

        output = null

        if self_id == data['userid']
          if !last_message
            output = div.children[2]
          else if last_message.getAttribute("data-user") == String(self_id)
            output = div.children[3]
          else
            output = div.children[2]
        else
          if !last_message
            output = div.children[0]
          else if last_message.getAttribute("data-user") == String(self_id)
            output = div.children[0]
          else
            output = div.children[1]

        if window.lastMessage
          window.lastMessage = false
        else
          newMessage.play()

        messages.append output

        container.animate({ scrollTop: container.prop("scrollHeight")}, 1000);

      send_message: (message, room_id) ->
        @perform 'send_message', message: message, room_id: room_id

    $('#newMessage').submit (e) ->
      $this = $(this)
      window.lastMessage = true
      textarea = $this.find('#message_content')
      if $.trim(textarea.val()).length > 1
        App.global_chat.send_message textarea.val(), messages.data('room-id')
        textarea.val('')
      e.preventDefault()
      return false
