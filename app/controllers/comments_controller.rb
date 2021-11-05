class CommentsController < ApplicationController
  before_action :new, only: [:create]

  def new
    @comment = Comment.new(author_id: params[:user_id], post_id: params[:id])
  end

  def create
    @comment.text = params[:comment]['text']

    if @comment.save
      redirect_to "/users/#{params[:user_id]}/posts/#{params[:id]}/"
    else
      redirect_to "/users/#{params[:user_id]}/posts/#{params[:id]}/comments/new"
    end
  end
end
