class UsersController < ApplicationController
  def index
    @user = current_user if user_signed_in?
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = User.recent_posts(@user)
  end
end
