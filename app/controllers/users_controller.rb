class UsersController < ApplicationController
  before_action :authenticate_user!, except: []
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'Your profile has been updated successfully.'
      redirect_to user_path(@user)
    else
      flash.now[:alert] = 'Failed to update your profile.'
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless current_user == @user
  end

end
