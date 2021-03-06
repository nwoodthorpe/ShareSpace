require 'test_helper'

class TextMessageTest < ActiveSupport::TestCase
  test "content length max enforced" do
    message = TextMessage.new(content: 'x'*2001)

    refute message.save
    assert message.errors[:content]
  end

  test "saves correctly" do
    message = TextMessage.new(content: 'Hello')

    assert message.save
  end

  test "factory saves to database" do
    TextMessage.factory('Hello')

    assert_equal TextMessage.last.content, 'Hello'
  end

  test 'render returns correct text' do
    message = TextMessage.new(content: 'Hello')

    assert_equal message.render, 'Hello'
  end
end
