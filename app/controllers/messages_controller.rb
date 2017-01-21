class MessagesController < ApplicationController
  def create
    byebug

    message = Message.new(
      room_id: params['room_id'],
      user_id: params['user_id'],
      content: params['message']['content']
    )

    message.save

    respond_to do |format|
      format.html
      format.js
    end
  end
end
