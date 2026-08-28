require "test_helper"

class BookCommentsControllerTest < ActionDispatch::IntegrationTest
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

  test "should create book comment" do
    post book_book_comments_path(@book), params: {
      book_comment: {
        comment: "Test comment"
      }
    }

    assert_response :success
  end

  test "should destroy book comment" do
    comment = @user.book_comments.create!(
      book: @book,
      comment: "Test comment"
    )

    delete book_book_comment_path(@book, comment)

    assert_response :success
  end
end