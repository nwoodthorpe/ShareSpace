require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user must have a name" do
    user = User.new

    refute user.save
    assert user.errors[:name]
  end

  test "user can exist independently of a Room" do
    user = User.new(room: nil, name: "Hello")

    refute user.save
  end

  test "user can belong to a Room" do
    room = rooms(:simple)
    user = User.new(room: room, name: "Hello")

    assert user.save
  end

  test "user is given a default last_active time" do
    user = User.new(last_active: nil, name: "Hello")

    assert user.save
    refute_equal user.last_active, nil
  end
end
