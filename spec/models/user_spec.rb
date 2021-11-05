require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create(name: 'Abimbola', photo: 'photo',
                        bio: 'biography of Abimbola',
                        posts_counter: 2)
  end

  it 'name is mandatory in user instance' do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  it 'posts_counter should be greater than zero' do
    @user.posts_counter = 0
    expect(@user).to be_valid
  end
end
