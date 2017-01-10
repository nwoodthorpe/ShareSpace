require 'test_helper'

class RoomsControllerTest < ActionDispatch::IntegrationTest
  test "POST to new redirects to new user path if user session not active" do
    post rooms_path

    assert_redirected_to new_user_path
  end

  test "POST to new returns success if user session exists" do
    init_user
    post rooms_path

    assert_response :success
  end

  test "POST to new deletes users old room if last user" do
    user = init_user
    room = Room.create

    room.users << user
    assert_equal room.users.count, 1

    post rooms_path
    assert_nil Room.find_by(id: room.id)
  end

  test "POST to new public creates new public room" do
    user = init_user

    assert_difference 'Room.count', +1 do
      post rooms_path, params: {public_room: true}
    end

    assert Room.last.public_room?
  end

  test "POST to new private creates new private room" do
    user = init_user

    assert_difference 'Room.count', +1 do
      post rooms_path, params: {public_room: false, password: "Hello World"}
    end

    assert Room.last.private_room?
  end

  test "POST to new private with invalid password shows error flash" do
    user = init_user

    post rooms_path, params: {public_room: false, password: "123"}

    assert_equal flash[:error], "Password is too short (minimum is 6 characters)"
  end

  def init_user
    post users_path, params: {user: User.new(name: "Bob")}, as: :json

    return User.last
  end
end