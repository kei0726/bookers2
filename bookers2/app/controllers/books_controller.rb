
class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user,only: [:edit ]
  
  def index
      @books = Book.all
      @book = Book.new
      @user = current_user
  end

  def show
      @book = Book.find(params[:id])
      @user = @book.user
      @booknew = Book.new

  end

  def new
  	  @book = Book.new
  end

  def create
  	  @book = Book.new(book_params)
      @book.user_id = current_user.id
      if @book.save
        flash[:notice] = "You have creatad book successfully."
        redirect_to book_path(@book.id)
      else
        @user = current_user
        @books = Book.all
        flash[:notice] = "errors prohibited this obj from being saved:" 
        render :index
      end
  end
  
  def edit
      @book = Book.find(params[:id])
  end

  def update
      @book = Book.find(params[:id])
      @book.update(book_params)
      if @book.save
         flash[:notice] = "You have updated book successfully."
         redirect_to book_path(@book)
    else
       @user = current_user
        @books = Book.all
        flash[:notice]  = "error prohibited this obj from being saved:"
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
  def ensure_correct_user
    book = Book.find(params[:id])
    if current_user != book.user
    flash[:notice] 
    redirect_to books_path
    end
   end
end