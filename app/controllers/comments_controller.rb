class CommentsController < ApplicationController
  before_action :new, only: [:create]

  def new
    @comment = Comment.new(author_id: params[:user_id], post_id: params[:id])
  end

  def create
    @comment.text = params[:comment]['text']

    if @comment.save
      flash[:notice] = 'Comment has been added!'
      redirect_to "/users/#{params[:user_id]}/posts/#{params[:id]}/"
    else
      flash[:notice] = 'Comment isnt added!'
      redirect_to "/users/#{params[:user_id]}/posts/#{params[:id]}/comments/new"
    end
  end
end
