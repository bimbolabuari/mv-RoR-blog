require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @user = User.create(name: 'Abimbola', photo: 'photo',
                        bio: 'biography of Abimbola',
                        posts_counter: 1)
    @post = Post.create(user_id: @user.id, title: 'My post',
                        text: 'My first post',
                        comments_counter: 2, likes_counter: 5)

    @comment1 = Comment.create(user_id: @user.id, post_id: @post.id, text: 'Nice')
    @comment2 = Comment.create(user_id: @user.id, post_id: @post.id, text: 'Goodluck')
  end

  it 'name length less or equal than 200 characters' do
    @post.title = 't' * 201
    expect(@post).to_not be_valid
  end

  it 'most_recent_comments method should return recent comments' do
    comments = Post.recent_comments(@post)
    expect(comments.length).to be(2)
  end

  it 'likes_counter should be greater than zero' do
    expect(@post).to_not be_valid
  end

  it 'comments_counter should be greater than zero' do
    expect(@post).to_not be_valid
  end
end
