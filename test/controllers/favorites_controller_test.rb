require "test_helper"

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @book = books(:one)

    post user_session_path, params: {
      user: {
        name: @user.name,
        password: "password"
      }
    }
  end

  test "should create favorite" do
    post book_favorite_path(@book)
    assert_response :success
  end

  test "should destroy favorite" do
    post book_favorite_path(@book)
    delete book_favorite_path(@book)
    assert_response :success
  end
end