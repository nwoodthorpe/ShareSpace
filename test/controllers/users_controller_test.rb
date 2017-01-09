require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "GET to new gives 200" do
    get new_user_path
    assert_response :success
  end

  test "POST to create with invalid params shows error flash" do
    post users_path, params: {user: User.new}, as: :json
    assert_equal flash[:error] ,'Could not create a user'
  end

  test "POST to create with invalid params redirects to new user" do
    post users_path, params: {user: User.new}, as: :json
    assert_redirected_to new_user_path
  end

  test "x" do
    assert_difference 'User.count', +1 do
      post users_path, params: {user: User.new(name: "Bob")}, as: :json
    end
  end

  test "POST to create with valid params creates user with correct name" do
    post users_path, params: {user: User.new(name: "Bob")}, as: :json

    assert_equal User.last.name, "Bob"
  end

  test "POST to create with valid params sets session[user_id]" do
    post users_path, params: {user: User.new(name: "Bob")}, as: :json

    assert_equal session[:user_id], User.last.id
  end

  test "POST to create with valid params redirects to root" do
    post users_path, params: {user: User.new(name: "Bob")}, as: :json

    assert_redirected_to root_path
  end
end
