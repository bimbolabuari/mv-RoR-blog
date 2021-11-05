class LikesController < ApplicationController
  def create
    @like = Like.new(author_id: params[:user_id], post_id: params[:id])
    @like.save
    redirect_to "/users/#{params[:user_id]}/posts/#{params[:id]}"
  end
end
