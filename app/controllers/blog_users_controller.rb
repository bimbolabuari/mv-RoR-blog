class BlogUsersController < ApplicationController
  def show
    render 'user'
  end

  def index
    render 'profile'
  end
end
