class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      flash[:alert] = "投稿に失敗しました"
      @books = Book.all
      render "index"
    end
  end

  def index
    @user = User.find(current_user.id)
    @books = Book.all
    @users = User.all
  end

  def show
    @user = User.find(current_user.id)
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
