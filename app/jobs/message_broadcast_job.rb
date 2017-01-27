class MessageBroadcastJob < ApplicationJob
  queue_as :default

  # Hack to deal with different message templates on the client side.
  def perform(message)
    ActionCable.server.broadcast "rooms_#{message.room.id}_channel",
                                 message: their_message(message),
                                 type: 'their',
                                 name: false,
                                 userid: message.user.id
    ActionCable.server.broadcast "rooms_#{message.room.id}_channel",
                                 message: their_message_name(message),
                                 type: 'their',
                                 name: true,
                                 userid: message.user.id
   ActionCable.server.broadcast "rooms_#{message.room.id}_channel",
                                 message: your_message(message),
                                 type: 'your',
                                 name: false,
                                 userid: message.user.id
    ActionCable.server.broadcast "rooms_#{message.room.id}_channel",
                                 message: your_message_name(message),
                                 type: 'your',
                                 name: true,
                                 userid: message.user.id
  end

  private

  def their_message_name(message)
    MessagesController.render partial: 'messages/their_message', locals: {message: message, skip_name: false}
  end

  def their_message(message)
    MessagesController.render partial: 'messages/their_message', locals: {message: message, skip_name: true}
  end

  def your_message_name(message)
    MessagesController.render partial: 'messages/your_message', locals: {message: message, skip_name: false}
  end

  def your_message(message)
    MessagesController.render partial: 'messages/your_message', locals: {message: message, skip_name: true}
  end
end
