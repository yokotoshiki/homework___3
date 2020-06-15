class UsersController < ApplicationController
# ログイン済ユーザーのみにアクセスを許可する
before_action :authenticate_user!
  def index
      @users = User.all
      @book = Book.new
  end
  def show
      @user = User.find(params[:id])
      @books = @user.books.page(params[:page]).reverse_order
      @book = Book.new
  end
  def edit
  	  @user = User.find(params[:id])
      if @user.id != current_user.id
      redirect_to user_path(current_user)
      end
  end
  def update
      @user = User.find(params[:id])
  if  @user.update(user_params)
      flash[:notice] = "User was successfully updated."
      redirect_to user_path(@user.id)
  else
       render 'edit'
  end
  end

private

  def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
