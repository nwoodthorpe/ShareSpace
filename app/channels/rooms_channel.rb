class RoomsChannel < ApplicationCable::Channel
  before_subscribe :authorize_subscribe

  def subscribed
    stream_from "rooms_#{params['room_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    (return false) unless current_user.room_id == data['room_id']
    current_user.messages.create!(content: data['message'], room_id: data['room_id'])
  end

  private

  def authorize_subscribe
    (return false) unless current_user.room_id == params['room_id']

    true
  end
end
