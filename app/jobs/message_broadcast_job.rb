class MessageBroadcastJob < ApplicationJob
  queue_as :default

  # Hack to deal with different message templates on the client side.
  def perform(message)
    ActionCable.server.broadcast "rooms_#{message.room.id}_channel",
                                 message: mix_message(message),
                                 userid: message.user.id
  end

  private

  def mix_message(message)
    MessagesController.render partial: 'messages/mix_messages', locals: {message: message}
  end
end
