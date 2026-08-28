require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)

    post user_session_path, params: {
      user: {
        name: @user.name,
        password: "password"
      }
    }
  end

  test "should get new" do
    get new_user_path
    assert_response :success
  end

  test "should get index" do
    get users_path
    assert_response :success
  end

  test "should get show" do
    get user_path(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_path(@user)
    assert_response :success
  end
end