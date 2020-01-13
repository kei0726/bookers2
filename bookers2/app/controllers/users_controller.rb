class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user,only: [:edit ]
  
  def show
  	  @user = User.find(params[:id])
  	  @book = Book.new
      @books = Book.all    
  end

  def index
      @user = current_user
      @users = User.all
      @book = Book.new

  end

  def edit
  	  @user = User.find(params[:id])
  end
  
  def update
      @user = User.find(params[:id])
      # binding.pry
      @user.update(user_params)
      if @user.save
         flash[:notice] = "You have updated user successfully."
         redirect_to user_path(@user)
    else
        @user = current_user
        @users = User.all
        flash[:notice] = "error prohibited this obj from being saved:"
        render :edit
      end
  end
  private
  def user_params
  	  params.require(:user).permit(:name, :profile_image, :introduction)
  end
   def book_params
      params.require(:book).permit(:title, :body)
  end
  def ensure_correct_user
    user = User.find(params[:id])
    if current_user != user
    flash[:notice] 
    redirect_to user_path(current_user)
   end
  end
end
