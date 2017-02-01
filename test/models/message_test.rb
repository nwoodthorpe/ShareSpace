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

  test "invalid if does not have content" do
    message = Message.new(room: @room, user: @user)

    refute message.save
    assert message.errors['conent_klass']
  end

  test 'valid if we set content correctly' do
    message = Message.new(room: @room, user: @user)
    message.set_content('TextMessage', 'Hello')

    assert message.save
  end

  test 'message renders correctly' do
    message = Message.new(room: @room, user: @user)
    message.set_content('TextMessage', 'Hello')

    message.save

    assert_equal message.render, 'Hello'
  end

  test 'message deletes content if deleted' do
    message = Message.new(room: @room, user: @user)
    message.set_content('TextMessage', 'Hello')
    content = TextMessage.last

    message.save
    message.destroy

    refute TextMessage.find_by(id: content.id)
  end
end
