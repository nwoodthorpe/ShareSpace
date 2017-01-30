class MessagesController < ApplicationController
  def create
    message = Message.new(
      room_id: params['room_id'],
      user_id: params['user_id']
    )
    message.set_content(params['type'], params['message'])
    message.save

    respond_to do |format|
      format.html
      format.js
    end
  end
end
