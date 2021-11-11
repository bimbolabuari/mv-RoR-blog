require 'rails_helper'

RSpec.describe 'Login page', js: true, type: :system do
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

  describe 'When the submit button is clicked' do
    it 'When username and password is incorrect, there is a detailed error' do
      visit new_user_session_path
      fill_in 'email', with: 'hello@example.com'
      fill_in 'password', with: '0000'
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'Empty username and password, I get a detailed error' do
      visit new_user_session_path
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'Logged in after correct data' do
      visit new_user_session_path
      fill_in 'email', with: 'ana@gmail.com'
      fill_in 'password', with: 'abcdefg'
      click_button 'Log in'
      expect(page).to have_content('Signed in successfully.')
    end
  end

  describe 'Login Page requirements' do
    it 'username and password inputs, and Log in button' do
      visit new_user_session_path
      expect(page).to have_field('email')
      expect(page).to have_field('password')
      expect(page).to have_button('Log in')
    end
  end
end
