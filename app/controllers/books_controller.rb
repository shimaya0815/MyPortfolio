class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:create, :edit, :update, :destroy]

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      flash[:notice] = 'You have created book successfully.'
      redirect_to @book
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = 'You have updated book successfully.'
      redirect_to @book
    else
      flash.now[:alert] = 'Failed to update the book.'
      render :edit
    end
  end


  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:notice] = 'Book was successfully deleted.'
    else
      flash[:alert] = 'Failed to delete the book.'
    end
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      redirect_to books_path unless current_user == @user
    elsif params[:id].present?
      @book = Book.find(params[:id])
      redirect_to books_path unless current_user == @book.user
    end
  end

end
