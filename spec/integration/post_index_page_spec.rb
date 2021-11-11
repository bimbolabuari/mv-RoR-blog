require 'rails_helper'

RSpec.describe 'Post index page', js: true, type: :system do
  before(:all) do
    @first_user = User.create(name: 'Abimbola', photo: 'photos',
                              bio: 'Biography of Abimbola',
                              posts_counter: 0, email: 'abimbola@gmail.com',
                              password: '0123456', confirmed_at: Time.now)
    @second_user = User.create(name: 'Ana', photo: 'photos',
                               bio: 'Biography of Ana',
                               posts_counter: 0, email: 'ana@gmail.com', password: 'abcdefg', confirmed_at: Time.now)
    @first_post = Post.create(title: 'My first post', text: 'This is my first post',
                              author_id: @first_user.id, comments_counter: 0, likes_counter: 0)
    @second_post = Post.create(title: 'My second post', text: 'This is my second post',
                               author_id: @first_user.id, comments_counter: 0, likes_counter: 0)
    @third_post = Post.create(title: 'My third post', text: 'This is my third post',
                              author_id: @first_user.id, comments_counter: 0, likes_counter: 0)
    @fourth_post = Post.create(title: 'My fourth post', text: 'This is my fourth post',
                               author_id: @first_user.id, comments_counter: 0, likes_counter: 0)
    Comment.create(text: 'This is my first comment', author_id: @second_user.id, post_id: @fourth_post.id)
    Comment.create(text: 'This is my second comment', author_id: @first_user.id, post_id: @fourth_post.id)
  end

  describe 'When a post is clicked' do
    it "Redirects to the post's show page" do
      visit new_user_session_path
      fill_in 'email', with: 'ana@gmail.com'
      fill_in 'password', with: 'abcdefg'
      click_button 'Log in'
      user = User.find_by(name: 'Ana')
      click_link user.name
      click_link 'See all posts'
      click_link user.posts.first.title
      expect(current_path).to eql(user_post_path(id: user.posts.first.id, user_id: user.id))
    end
  end
end

describe 'All user details' do
  it "the user's username" do
    visit new_user_session_path
    fill_in 'email', with: 'ana@gmail.com'
    fill_in 'password', with: 'abcdefg'
    click_button 'Log in'
    user = User.find_by(name: 'Ana')
    click_link user.name
    click_link 'See all posts'
    expect(page).to have_content(user.name)
  end

  it 'Number of user post' do
    visit new_user_session_path
    fill_in 'email', with: 'ana@gmail.com'
    fill_in 'password', with: 'abcdefg'
    click_button 'Log in'
    user = User.find_by(name: 'Ana')
    click_link user.name
    click_link 'See all posts'
    expect(page).to have_content("Number of posts: #{user.posts_counter}")
  end

  it "post's title" do
    visit new_user_session_path
    fill_in 'email', with: 'ana@gmail.com'
    fill_in 'password', with: 'abcdefg'
    click_button 'Log in'
    user = User.find_by(name: 'Ana')
    click_link user.name
    click_link 'See all posts'
    expect(page).to have_content(user.posts.first.title)
  end

  it 'the first comment on a post' do
    visit new_user_session_path
    fill_in 'email', with: 'ana@gmail.com'
    fill_in 'password', with: 'abcdefg'
    click_button 'Log in'
    user = User.find_by(name: 'Ana')
    click_link user.name
    click_link 'See all posts'
    expect(page).to have_content(user.posts.last.comments.first.text)
  end

  it 'how many comments a post has' do
    visit new_user_session_path
    fill_in 'email', with: 'ana@gmail.com'
    fill_in 'password', with: 'abcdefg'
    click_button 'Log in'
    user = User.find_by(name: 'Ana')
    click_link user.name
    click_link 'See all posts'
    expect(page).to have_content("Comments: #{user.posts.first.comments_counter}")
  end

  it 'how many likes a post has' do
    visit new_user_session_path
    fill_in 'email', with: 'ana@gmail.com'
    fill_in 'password', with: 'abcdefg'
    click_button 'Log in'
    user = User.find_by(name: 'Ana')
    click_link user.name
    click_link 'See all posts'
    expect(page).to have_content("Likes: #{user.posts.first.likes_counter}")
  end
end
