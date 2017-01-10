class RoomsController < ApplicationController
  before_action :require_user_session, only: [:create]

  def create
    public_room = str_to_bool(user_params[:public_room])

    delete_room_if_last_user(current_user.room_id)

    @room = Room.new(
      public_room: public_room,
      locked: false,
      password: user_params[:password]
    )

    if !@room.save
      flash[:error] = @room.errors.full_messages.join(', ')
      redirect_to root_path and return
    end

    @room.users << current_user

    if public_room
      render 'rooms/public'
    else
      render 'rooms/private'
    end
  end

  private

  def user_params
    params.permit(:public_room, :password)
  end

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
