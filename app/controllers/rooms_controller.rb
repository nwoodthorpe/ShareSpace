class RoomsController < ApplicationController
  before_action :require_user_session
  before_action :find_room, only: [:index, :authenticate]

  def index
    if @room.private_room?
      (ask_for_password and return) unless @room.users.include? current_user
    else
      @room.users << current_user
    end

    @user = current_user

    @messages = @room.messages
    @message = Message.new
  end

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

    redirect_to view_room_path(@room.short_url)
  end

  private

  def authenticate
    render 'rooms/auth'
  end

  def user_params
    params.permit(:public_room, :password)
  end

  def require_user_session
    unless current_user
      set_last_request
      redirect_to new_user_path
    end
  end

  def find_room
    @url = params[:short_url]
    @room = Room.find_by(short_url: @url)

    unless @room
      flash[:error] = "Could not find room: #{params[:short_url]}"
      redirect_to root_path and return
    end
  end

  def delete_room_if_last_user(room_id)
    return unless (room = Room.find_by(id: room_id))
    room.delete if room.users.count == 1
  end

  def str_to_bool(str)
    return false if str == 'false'
    return true
  end

  def ask_for_password
    render 'rooms/auth'
  end
end
