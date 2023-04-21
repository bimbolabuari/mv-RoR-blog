require 'rails_helper'

RSpec.describe 'Post page', js: true, type: :feature do
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

  describe 'Details of post, Likes and comments' do
    it 'numbers of likes' do
      visit new_user_session_path
      fill_in 'email', with: 'ana@gmail.com'
      fill_in 'password', with: 'abcdefg'
      click_button 'Log in'
      user = User.find_by(name: 'Ana')
      click_link user.name
      click_link user.posts.last.title
      expect(page).to have_content("Likes: #{user.posts.last.likes_counter}")
      click_button 'Like'
      expect(page).to have_content("Likes: #{user.posts.last.likes_counter}")
    end

    it 'Post Author' do
      visit new_user_session_path
      fill_in 'email', with: 'ana@gmail.com'
      fill_in 'password', with: 'abcdefg'
      click_button 'Log in'
      user = User.find_by(name: 'Ana')
      click_link user.name
      click_link user.posts.last.title
      expect(page).to have_content(user.name)
    end

    it "the post's title" do
      visit new_user_session_path
      fill_in 'email', with: 'ana@gmail.com'
      fill_in 'password', with: 'abcdefg'
      click_button 'Log in'
      user = User.find_by(name: 'Ana')
      click_link user.name
      click_link user.posts.last.title
      expect(page).to have_content(user.posts.last.title)
    end

    it 'the post body' do
      visit new_user_session_path
      fill_in 'email', with: 'ana@gmail.com'
      fill_in 'password', with: 'abcdefg'
      click_button 'Log in'
      user = User.find_by(name: 'Ana')
      click_link user.name
      click_link user.posts.last.title
      expect(page).to have_content(user.posts.last.text)
    end

    it 'the username of each commentor' do
      visit new_user_session_path
      fill_in 'email', with: 'ana@gmail.com'
      fill_in 'password', with: 'abcdefg'
      click_button 'Log in'
      user = User.find_by(name: 'Ana')
      click_link user.name
      click_link user.posts.last.title
      user.posts.last.comments.each do |comment|
        expect(page).to have_content(comment.author.name)
      end
    end

    it 'the comment each commentor left' do
      visit new_user_session_path
      fill_in 'email', with: 'ana@gmail.com'
      fill_in 'password', with: 'abcdefg'
      click_button 'Log in'
      user = User.find_by(name: 'Ana')
      click_link user.name
      click_link user.posts.last.title
      user.posts.last.comments.each do |comment|
        expect(page).to have_content("#{comment.author.name}: #{comment.text}")
      end
    end
  end

  it 'Number of comments' do
    visit new_user_session_path
    fill_in 'email', with: 'ana@gmail.com'
    fill_in 'password', with: 'abcdefg'
    click_button 'Log in'
    user = User.find_by(name: 'Ana')
    click_link user.name
    click_link user.posts.last.title
    expect(page).to have_content("Comments: #{user.posts.last.comments_counter}")
  end
end
