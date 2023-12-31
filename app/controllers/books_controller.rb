class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def new
    @book = Book.new
  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user = current_user
    @book.user_id = current_user.id
    @books = Book.all
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
    @users = User.all
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = current_user
    @book_comment = BookComment.new
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
      @books = Book.all
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:notice]="Book was successfully destroyed."
      redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    unless @user == current_user
      redirect_to(books_path)
    end
  end


end
