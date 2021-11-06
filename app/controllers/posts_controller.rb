class PostsController < ApplicationController
  before_action :new, only: [:create]

  def index
    @user = User.find(params[:user_id])
    @posts = Post.joins(:author).where(author: { id: @user.id }).order(created_at: :desc)
    @comments = Comment.includes(:author).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @post = @user.post.includes(:comment)
    @comments = Comment.includes(:author).order(created_at: :desc)
  end

  def new
    @post = Post.new(comments_counter: 0, likes_counter: 0, author_id: params[:user_id])
  end

  def create
    @post.title = params[:post]['title']
    @post.text = params[:post]['text']
    @post.author_id = params[:user_id]
    @post.comments_counter = 0
    @post.likes_counter = 0
    @post.save
    Post.update_post_counter(User.find(params[:user_id]))
    flash[:notice] = 'Post added'
    redirect_to user_posts_url(@post.author_id)

    if @post.save
      redirect_to "/users/#{params[:user_id]}/posts/#{@post.id}"
    else
      redirect_to "/users/#{params[:user_id]}/posts/new"
    end
  end
end
