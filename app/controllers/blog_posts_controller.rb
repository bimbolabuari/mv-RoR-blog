class BlogPostsController < ApplicationController
  def show
    render 'post'
  end

  def index
    render 'posts'
  end
end
