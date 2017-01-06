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
    room = Room.new(public_room: false)

    assert room.private_room?
  end

  test "room creates short_url if not given one" do
    room = Room.new

    assert room.save
    refute_equal room.short_url, nil
  end

  test "rooms are not given same short_url" do
    room1 = Room.new
    room2 = Room.new

    assert (room1.save && room2.save)
    refute_equal room1.short_url, room2.short_url
  end

  test "locked is given a default value" do
    room1 = Room.new

    assert room1.save
    refute_equal room1.locked, nil
  end

  test "public_room is given a default value" do
    room1 = Room.new

    assert room1.save
    refute_equal room1.public_room, nil
  end
end
