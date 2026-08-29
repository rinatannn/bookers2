class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @books = Book
      .left_joins(:favorites)
      .group("books.id")
      .order(
        Arel.sql(
          "SUM(CASE WHEN favorites.created_at >= '#{1.week.ago.to_fs(:db)}' THEN 1 ELSE 0 END) DESC"
        )
      )

    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @book.increment!(:view_count)
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_create_params)
    @book.user_id = current_user.id

    if @book.save
      redirect_to book_path(@book.id),
                  notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_update_params)
      redirect_to book_path(@book.id),
                  notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_create_params
    params.require(:book).permit(:title, :body, :score)
  end

  def book_update_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    book = Book.find(params[:id])

    unless book.user == current_user
      redirect_to books_path
    end
  end
end