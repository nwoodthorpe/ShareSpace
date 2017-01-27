class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "rooms_#{message.room.id}_channel",
                                 message: render_message(message)
  end

  private

  def render_message(message)
    MessagesController.render partial: 'messages/their_message', locals: {message: message, skip_name: true}
    MessagesController.render partial: 'messages/your_message', locals: {message: message, skip_name: true}
  end
end
