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
    room = Room.new(public_room: false, password: "password123")

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
    room = Room.new

    assert room.save
    refute_equal room.locked, nil
  end

  test "public_room is given a default value" do
    room = Room.new

    assert room.save
    refute_equal room.public_room, nil
  end

  test "private room with no password is invalid" do
    room = Room.new(public_room: false)

    refute room.save
    assert room.errors[:password]
  end

  test "public room with password has password ignored" do
    room = Room.new(public_room: true, password: "password123")

    assert room.save
    assert_nil room.encrypted_password
  end

  test "private room with password is valid" do
    room = Room.new(public_room: false, password: "password123")

    assert room.save
  end

  test "private room with short password is invalid" do
    room = Room.new(public_room: false, password: "H")

    refute room.save
    assert room.errors[:password]
  end

  test "private room with long password is invalid" do
    room = Room.new(public_room: false, password: "H"*101)

    refute room.save
    assert room.errors[:password]
  end

  test "plaintext password is not stored in encrypted password" do
    room_password = "password"
    room = Room.new(public_room: false, password: room_password)

    assert room.save
    refute_equal room.encrypted_password, room_password
  end

  test "plaintext password is not stored in password field" do
    room = Room.new(public_room: false, password: "password")

    assert room.save
    assert_nil room.reload.password
  end
end
