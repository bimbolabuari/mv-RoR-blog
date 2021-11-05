require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:each) do
    @user = User.create(name: 'Abimbola', photo: 'photo',
                        bio: 'biography of Abimbola',
                        posts_counter: 6)
    @post = Post.create(user_id: @user.id, title: 'My post',
                        text: 'My first post',
                        comments_counter: 1, likes_counter: 3)
    @like1 = Like.create(user_id: @user.id, post_id: @post.id)
    @like2 = Like.create(user_id: @user.id, post_id: @post.id)
  end

  it 'update_likes_counter method should update the likes counter of a post' do
    Like.update_like_counter(@post)
    expect(@post.likes_counter).to be(4)
  end
end
