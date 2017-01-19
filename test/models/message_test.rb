require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def setup
    @user = users(:simple)
    @room = rooms(:simple)
  end

  test "invalid if message does not belong to room" do
    message = Message.new(user: @user)

    refute message.save
    assert message.errors['room']
  end

  test "invalid if message does not belong to user" do
    message = Message.new(room: @room)

    refute message.save
    assert message.errors['room']
  end

  test "room is valid with room and user" do
    message = Message.new(room: @room, user: @user)

    assert message.save
  end

  test "room message defaults to empty string" do
    message = Message.create(room: @room, user: @user)

    assert_equal message.content, ""
  end
end
