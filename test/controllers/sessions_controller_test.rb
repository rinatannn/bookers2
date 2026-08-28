require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_session_path
    assert_response :success
  end

  test "should create session" do
    user = users(:one)

    post user_session_path, params: {
      user: {
        name: user.name,
        password: "password"
      }
    }

    assert_redirected_to user_path(user)
  end

  test "should destroy session" do
    get destroy_user_session_path
    assert_redirected_to root_path
  end
end