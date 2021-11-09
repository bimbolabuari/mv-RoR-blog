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
    if user_signed_in?
      @user = current_user
      @post = @user.posts.create(params.require(:post).permit(:title, :text))
      if @post.save
        flash[:notice] = 'Post saved successfully'
        redirect_to user_post_url
      else
        flash.now[:error] = 'Error: Post could not be saved'
        render :new, locals: { post: @post }
      end
    else
      flash.now[:error] = 'Error: Please sign up to make a posts.'
      redirect_to root_path
    end
  end
end
