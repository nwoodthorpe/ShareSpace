class MessagesController < ApplicationController
  def create
    message = Message.new(
      room_id: params['room_id'],
      user_id: params['user_id'],
      content: params['message']
    )
    
    respond_to do |format|
      format.html
      format.js
    end
  end
end
