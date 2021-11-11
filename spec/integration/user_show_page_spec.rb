require 'rails_helper'

RSpec.describe 'User main page', js: true, type: :feature do
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

  describe 'View all user details on user main page' do
    it 'Number of user post' do
      visit new_user_session_path
      fill_in 'email', with: 'ana@gmail.com'
      fill_in 'password', with: 'abcdefg'
      click_button 'Log in'
      users = User.all
      click_link users[0].name
      expect(page).to have_content("Number of posts: #{users[0].posts_counter}")
    end

    it 'the user\'s bio' do
      visit new_user_session_path
      fill_in 'email', with: 'ana@gmail.com'
      fill_in 'password', with: 'abcdefg'
      click_button 'Log in'
      users = User.all
      click_link users[0].name
      expect(page).to have_content(users[0].bio)
    end

    it "the user's first 3 posts" do
      visit new_user_session_path
      fill_in 'email', with: 'ana@gmail.com'
      fill_in 'password', with: 'abcdefg'
      click_button 'Log in'
      user = User.find_by(name: 'Ana')
      click_link user.name
      expect(page).to have_content(user.posts[3].title)
      expect(page).to have_content(user.posts[2].title)
      expect(page).to have_content(user.posts[1].title)
      expect(page).to_not have_content(user.posts[0].title)
    end

    it "the user's profile picture" do
      visit new_user_session_path
      fill_in 'email', with: 'ana@gmail.com'
      fill_in 'password', with: 'abcdefg'
      click_button 'Log in'
      users = User.all
      click_link users[0].name
      expect(page.find('.profile-photo-img')['src']).to have_content(users[0].photo)
    end

    it "the user's username" do
      visit new_user_session_path
      fill_in 'email', with: 'ana@gmail.com'
      fill_in 'password', with: 'abcdefg'
      click_button 'Log in'
      users = User.all
      click_link users[0].name
      expect(page).to have_content(users[0].name)
    end
  end
end
