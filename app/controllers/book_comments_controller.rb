class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id

    if comment.save
      redirect_back(fallback_location: book_path(book))
    else
      redirect_back(fallback_location: book_path(book))
    end
  end

  def destroy
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.find_by(id: params[:id], book_id: book.id)

    comment&.destroy

    redirect_back(fallback_location: book_path(book))
  end

  private

  def book_comment_params
    params.expect(book_comment: [:comment])
  end
end