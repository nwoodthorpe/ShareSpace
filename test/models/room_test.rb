require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  def setup
    @user1 = User.new
    @user2 = User.new
  end

  test "room can own a user" do
    room = rooms(:simple)

    room.users << @user1

    assert_equal @user1, room.users[0]
  end

  test "room can own multiple users" do
    room = rooms(:simple)

    room.users << @user1
    room.users << @user2

    assert_equal @user1, room.users[0]
    assert_equal @user2, room.users[1]
  end

  test "private_room? helper is correct" do
    room = Room.new(public_room: false, short_url: "Hello")

    assert room.private_room?
  end

  test "locked cannot be nil" do
    room = Room.new(locked: nil, short_url: "Hello")

    refute room.save
    assert room.errors[:public_room]
  end

  test "public_room cannot be nil" do
    room = Room.new(public_room: nil, short_url: "Hello")

    refute room.save
    assert room.errors[:public_room]
  end
end
