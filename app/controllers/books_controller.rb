class BooksController < ApplicationController
# ログイン済ユーザーのみにアクセスを許可する
before_action :authenticate_user!

  def index
  	   @books = Book.page(params[:page]).reverse_order
  	   @book = Book.new
  end

  def show
  	  @book = Book.find(params[:id])
  end

  def new
  	  @book = Book.new
      @book = Book.all
  end

  def create
  	  @book = Book.new(book_params)
  	  @book.user_id = current_user.id
      if @book.save
        flash[:notice] = "Book was successfully created."
  	    redirect_to book_path(@book)
      else
        @books = Book.page(params[:page]).reverse_order
        render 'index'
    end
  end

  def edit
      @book = Book.find(params[:id])
      if @book.user.id != current_user.id
         redirect_to books_path
      end
  end

  def update
      @book = Book.find(params[:id])
      if @book.update(book_params)
         flash[:notice] = "Book was successfully updated."
         redirect_to book_path(@book)
      else
         @books = Book.page(params[:page]).reverse_order
         render 'index'
      end
  end

  def destroy
      @book = Book.find(params[:id])
      @book.destroy
      flash[:notice] = "Book was successfully destroyed."
      redirect_to books_path
  end

private

   def book_params
   	   params.require(:book).permit(:title, :body, :user_id)
   end

end
