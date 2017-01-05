require 'test_helper'

class StaticControllerTest < ActionDispatch::IntegrationTest
  test "request to home gives 200" do
    get root_url
    assert_response :success
  end
end
