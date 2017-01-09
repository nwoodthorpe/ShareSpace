class RoomsController < ApplicationController
  before_action :require_user_session, only: [:new]

  def new
    public_room = str_to_bool(params[:public_room])

    delete_room_if_last_user(current_user.room_id)

    @room = Room.create(
      public_room: public_room,
      locked: false
    )

    @room.users << current_user

    if public_room
      render 'rooms/public'
    else
      render 'rooms/private'
    end
  end

  private

  def require_user_session
    unless current_user
      set_last_request
      redirect_to new_user_path
    end
  end

  def set_last_request
    session[:last_request] = {
      url: request.original_url,
      params: params
    }
  end

  def delete_room_if_last_user(room_id)
    return unless (room = Room.find_by(id: room_id))
    room.delete if room.users.count == 1
  end

  def str_to_bool(str)
    return false if str == 'false'
    return true
  end
end
