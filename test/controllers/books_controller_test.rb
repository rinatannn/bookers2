require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
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

  test "should get index" do
    get books_path
    assert_response :success
  end

  test "should get show" do
    get book_path(@book)
    assert_response :success
  end

  test "should get edit" do
    get edit_book_path(@book)
    assert_response :success
  end
end