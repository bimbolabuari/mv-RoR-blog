require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET users/index/posts' do
    before { get '/users/1/posts' }
    it 'response status was correct' do
      expect(response).to have_http_status(:ok)
    end
    it 'correct template was rendered' do
      expect(response).to render_template('index')
    end
    it 'response body includes correct placeholder text' do
      expect(response.body).to include('This is user individual post')
    end
  end

  describe 'GET users/index/posts/1' do
    before { get '/users/1/posts/1' }
    it 'response status was correct' do
      expect(response).to have_http_status(:ok)
    end
    it 'correct template was rendered' do
      expect(response).to render_template('show')
    end
    it 'response body includes correct placeholder text' do
      expect(response.body).to include('These are users post')
    end
  end
end
