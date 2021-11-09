require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @user = User.create(name: 'Abimbola', photo: 'photo',
                        bio: 'biography of Abimbola',
                        posts_counter: 4)
    @post = Post.create(user_id: @user.id, title: 'My post',
                        text: 'My first post',
                        comments_counter: 1, likes_counter: 3)
    @comment1 = Comment.create(user_id: @user.id, post_id: @post.id, text: 'Nice')
    @comment2 = Comment.create(user_id: @user.id, post_id: @post.id, text: 'Goodluck')
  end

  it 'update_comments_counter method should update the comments counter of a post' do
    Comment.update_comment_counter(@post)
    expect(@post.comments_counter).to be(2)
  end
end
