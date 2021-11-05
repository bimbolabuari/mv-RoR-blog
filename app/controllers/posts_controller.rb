class PostsController < ApplicationController
  before_action :new, only: [:create]

  def index
    @user = User.find(params[:user_id])
    @posts = Post.joins(:author).where(author: { id: @user.id }).order(created_at: :desc)
    @comments = Comment.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = Comment.order(created_at: :desc)
  end

  def new
    @post = Post.new(comments_counter: 0, likes_counter: 0, author_id: params[:user_id])
  end

  def create
    @post.title = params[:post]['title']
    @post.text = params[:post]['text']

    if @post.save
      redirect_to "/users/#{params[:user_id]}/posts/#{@post.id}"
    else
      redirect_to "/users/#{params[:user_id]}/posts/new"
    end
  end
end
