# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@App = {}
App.cable = ActionCable.createConsumer('cable')

window.lastMessage = false

jQuery(document).on 'turbolinks:load', ->
  messages = $('#message-container')
  messages_loading = $('#message-container-loading')

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

      disconnected: ->
        # Called when the subscription has been terminated by the server
        console.log('We are now disconnected')

      received: (data) ->
        if window.lastMessage
          window.lastMessage = false
        else
          newMessage.play()

        messages.append data['message']

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
