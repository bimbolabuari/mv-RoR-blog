class LikesController < ApplicationController
  def create
    @like = Like.new(author_id: params[:user_id], post_id: params[:id])
    @like.save
    Like.update_like_counter(@post)
    flash[:notice] = 'Liked'
    redirect_to "/users/#{params[:user_id]}/posts/#{params[:id]}"
  end
end
