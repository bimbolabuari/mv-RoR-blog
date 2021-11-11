require 'rails_helper'

RSpec.describe 'User page', js: true, type: :system do
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

  describe 'Details of user' do
    it 'All users profile picture' do
      visit new_user_session_path
      fill_in 'email', with: 'ana@gmail.com'
      fill_in 'password', with: 'abcdefg'
      click_button 'Log in'
      users = User.all
      visit users_path
      expect(page.first('.profile-photo-img')['src']).to have_content(users[0].photo)
    end

    it 'Number of posts per user' do
      visit new_user_session_path
      fill_in 'email', with: 'ana@gmail.com'
      fill_in 'password', with: 'abcdefg'
      click_button 'Log in'
      users = User.all
      visit users_path
      users.each do |user|
        expect(page).to have_content(user.posts_counter)
      end
    end

    it 'View all user username' do
      visit new_user_session_path
      fill_in 'email', with: 'ana@gmail.com'
      fill_in 'password', with: 'abcdefg'
      click_button 'Log in'
      users = User.all
      visit users_path
      users.each do |user|
        expect(page).to have_content(user.name)
      end
    end
  end

  describe 'When a user is clicked, ' do
    it 'Redirect to the user main page' do
      visit new_user_session_path
      fill_in 'email', with: 'ana@gmail.com'
      fill_in 'password', with: 'abcdefg'
      click_button 'Log in'
      users = User.all
      click_link users[0].name
      expect(current_path).to eql(user_path(id: users[0].id))
    end
  end
end
