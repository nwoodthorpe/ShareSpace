require 'test_helper'

class RoomsControllerTest < ActionDispatch::IntegrationTest
  test "GET to new redirects to new user path if user session not active" do
    get new_room_path

    assert_redirected_to new_user_path
  end

  test "GET to new returns success if user session exists" do
    init_user
    get new_room_path

    assert_response :success
  end

  test "GET to new deletes users old room if last user" do
    user = init_user
    room = Room.create

    room.users << user
    assert_equal room.users.count, 1

    get new_room_path
    assert_nil Room.find_by(id: room.id)
  end

  test "GET to new public creates new public room" do
    user = init_user

    assert_difference 'Room.count', +1 do
      get new_room_path, params: {public_room: true}
    end

    assert Room.last.public_room?
  end

  test "GET to new private creates new private room" do
    user = init_user

    assert_difference 'Room.count', +1 do
      get new_room_path, params: {public_room: false}
    end

    assert Room.last.private_room?
  end

  def init_user
    post users_path, params: {user: User.new(name: "Bob")}, as: :json

    return User.last
  end
end
