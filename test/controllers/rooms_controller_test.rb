require 'test_helper'

class RoomsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @public_room = Room.create(
      public_room: true,
      locked: false,
    )

    @private_password = 'password'
    @private_room = Room.create(
      public_room: false,
      locked: false,
      password: @private_password
    )
  end

  test "POST to create redirects to new user path if user session not active" do
    post rooms_path

    assert_redirected_to new_user_path
  end

  test "POST to create redirects to new room if user session exists" do
    init_user
    post rooms_path

    assert_redirected_to view_room_path(Room.last.short_url)
  end

  test "POST to create deletes users old room if last user" do
    user = init_user
    room = Room.create

    room.users << user
    assert_equal room.users.count, 1

    post rooms_path
    assert_nil Room.find_by(id: room.id)
  end

  test "POST to create public creates new public room" do
    user = init_user

    assert_difference 'Room.count', +1 do
      post rooms_path, params: {public_room: true}
    end

    assert Room.last.public_room?
  end

  test "POST to create private creates new private room" do
    user = init_user

    assert_difference 'Room.count', +1 do
      post rooms_path, params: {public_room: false, password: "Hello World"}
    end

    assert Room.last.private_room?
  end

  test "POST to create private with invalid password shows error flash" do
    user = init_user

    post rooms_path, params: {public_room: false, password: "123"}

    assert_equal flash[:error], "Password is too short (minimum is 6 characters)"
  end

  test "GET to index redirects to new user path if user not logged in" do
    get view_room_path(short_url: @public_room.short_url)

    assert_redirected_to new_user_path
  end

  test 'GET to index with invalid short_url redirects to root' do
    init_user

    get view_room_path(short_url: "x")

    assert_redirected_to root_path
  end
  
  test 'GET to index with invalid short_url shows helpful flash message' do
    init_user

    get view_room_path(short_url: "x")

    assert_equal flash[:error], "Could not find room: x"
  end

  test 'GET to index with valid short_url returns success' do
    init_user
    get view_room_path(short_url: @public_room.short_url)

    assert_response :success
  end

  test 'GET to index with valid short_url to public room renders index' do
    @public_room.users << init_user
    get view_room_path(short_url: @public_room.short_url)

    assert_template :index
  end

  test 'GET to index with valid short_url to public room user is not in adds user' do
    user = init_user
    get view_room_path(short_url: @public_room.short_url)

    assert_equal user.reload.room, @public_room
  end

  test 'GET to index with valid short_url to private room that user belongs to renders index' do
    @private_room.users << init_user

    get view_room_path(short_url: @private_room.short_url)

    assert_response :success
    assert_template :index
  end

  test 'GET to index with valid short_url to private room that user does not belong to renders auth' do
    init_user

    get view_room_path(short_url: @private_room.short_url)

    assert_template 'rooms/auth'
  end

  def init_user
    post users_path, params: {user: User.new(name: "Bob")}, as: :json

    return User.last
  end
end
