class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @users = User.all
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "You have updated user successfully."
      redirect_to user_path(current_user.id)
    else
      render 'edit'
    end
  end

  def index
    @user = User.find(current_user.id)
    @users = User.all
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
